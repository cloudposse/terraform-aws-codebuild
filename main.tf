data "aws_caller_identity" "default" {
}

data "aws_region" "default" {
}

module "label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.4.0"
  namespace  = var.namespace
  name       = var.name
  stage      = var.stage
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_s3_bucket" "cache_bucket" {
  count         = var.enabled && local.s3_cache_enabled ? 1 : 0
  bucket        = local.cache_bucket_name_normalised
  acl           = "private"
  force_destroy = true
  tags          = module.label.tags

  lifecycle_rule {
    id      = "codebuildcache"
    enabled = true

    prefix = "/"
    tags   = module.label.tags

    expiration {
      days = var.cache_expiration_days
    }
  }
}

resource "random_string" "bucket_prefix" {
  count   = var.enabled ? 1 : 0
  length  = 12
  number  = false
  upper   = false
  special = false
  lower   = true
}

locals {
  cache_bucket_name = "${module.label.id}${var.cache_bucket_suffix_enabled ? "-${join("", random_string.bucket_prefix.*.result)}" : ""}"

  ## Clean up the bucket name to use only hyphens, and trim its length to 63 characters.
  ## As per https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html
  cache_bucket_name_normalised = substr(
    join("-", split("_", lower(local.cache_bucket_name))),
    0,
    min(length(local.cache_bucket_name), 63),
  )

  s3_cache_enabled = var.cache_type == "S3"

  ## This is the magic where a map of a list of maps is generated
  ## and used to conditionally add the cache bucket option to the
  ## aws_codebuild_project
  cache_options = {
    "S3" = {
      type     = "S3"
      location = var.enabled && local.s3_cache_enabled ? join("", aws_s3_bucket.cache_bucket.*.bucket) : "none"

    },
    "LOCAL" = {
      type  = "LOCAL"
      modes = var.local_cache_modes
    },
    "NO_CACHE" = {
      type = "NO_CACHE"
    }
  }

  # Final Map Selected from above
  cache = local.cache_options[var.cache_type]
}

resource "aws_iam_role" "default" {
  count                 = var.enabled ? 1 : 0
  name                  = module.label.id
  assume_role_policy    = data.aws_iam_policy_document.role.json
  force_detach_policies = true
}

data "aws_iam_policy_document" "role" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_policy" "default" {
  count  = var.enabled ? 1 : 0
  name   = module.label.id
  path   = "/service-role/"
  policy = data.aws_iam_policy_document.permissions.json
}

resource "aws_iam_policy" "default_cache_bucket" {
  count = var.enabled && local.s3_cache_enabled ? 1 : 0


  name   = "${module.label.id}-cache-bucket"
  path   = "/service-role/"
  policy = join("", data.aws_iam_policy_document.permissions_cache_bucket.*.json)
}

data "aws_iam_policy_document" "permissions" {
  statement {
    sid = ""

    actions = compact(concat([
      "codecommit:GitPull",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
      "ecs:RunTask",
      "iam:PassRole",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ssm:GetParameters",
      "ec2:*",
      "secretsmanager:GetSecretValue",
      "ec2:*",
    ], var.extra_permissions))
      
    effect = "Allow"

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "permissions_cache_bucket" {
  count = var.enabled && local.s3_cache_enabled ? 1 : 0
  statement {
    sid = ""

    actions = [
      "s3:*",
    ]

    effect = "Allow"

    resources = [
      join("", aws_s3_bucket.cache_bucket.*.arn),
      "${join("", aws_s3_bucket.cache_bucket.*.arn)}/*",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = var.enabled ? 1 : 0
  policy_arn = join("", aws_iam_policy.default.*.arn)
  role       = join("", aws_iam_role.default.*.id)
}

resource "aws_iam_role_policy_attachment" "default_cache_bucket" {
  count      = var.enabled && local.s3_cache_enabled ? 1 : 0
  policy_arn = join("", aws_iam_policy.default_cache_bucket.*.arn)
  role       = join("", aws_iam_role.default.*.id)
}

resource "aws_codebuild_source_credential" "authorization" {
  count       = var.enabled && var.private_repository ? 1 : 0
  auth_type   = var.source_credential_auth_type
  server_type = var.source_credential_server_type
  token       = var.source_credential_token
  user_name   = var.source_credential_user_name
}

resource "aws_codebuild_project" "default" {
  count          = var.enabled ? 1 : 0
  name           = module.label.id
  service_role   = join("", aws_iam_role.default.*.arn)
  badge_enabled  = var.badge_enabled
  build_timeout  = var.build_timeout
  source_version = var.source_version != "" ? var.source_version : null
  tags = {
    for name, value in module.label.tags :
    name => value
    if length(value) > 0
  }

  artifacts {
    type = var.artifact_type
  }

  cache {
    type     = lookup(local.cache, "type", null)
    location = lookup(local.cache, "location", null)
    modes    = lookup(local.cache, "modes", null)
  }

  environment {
    compute_type    = var.build_compute_type
    image           = var.build_image
    type            = var.build_type
    privileged_mode = var.privileged_mode

    environment_variable {
      name  = "AWS_REGION"
      value = signum(length(var.aws_region)) == 1 ? var.aws_region : data.aws_region.default.name
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = signum(length(var.aws_account_id)) == 1 ? var.aws_account_id : data.aws_caller_identity.default.account_id
    }

    dynamic "environment_variable" {
      for_each = signum(length(var.image_repo_name)) == 1 ? [""] : []
      content {
        name  = "IMAGE_REPO_NAME"
        value = var.image_repo_name
      }
    }

    dynamic "environment_variable" {
      for_each = signum(length(var.image_tag)) == 1 ? [""] : []
      content {
        name  = "IMAGE_TAG"
        value = var.image_tag
      }
    }

    dynamic "environment_variable" {
      for_each = signum(length(var.stage)) == 1 ? [""] : []
      content {
        name  = "STAGE"
        value = var.stage
      }
    }

    dynamic "environment_variable" {
      for_each = signum(length(var.github_token)) == 1 ? [""] : []
      content {
        name  = "GITHUB_TOKEN"
        value = var.github_token
      }
    }

    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
      }
    }

  }

  source {
    buildspec           = var.buildspec
    type                = var.source_type
    location            = var.source_location
    report_build_status = var.report_build_status
    git_clone_depth     = var.git_clone_depth != null ? var.git_clone_depth : null

    dynamic "auth" {
      for_each = var.private_repository ? [""] : []
      content {
        type     = "OAUTH"
        resource = join("", aws_codebuild_source_credential.authorization.*.id)
      }
    }

    dynamic "git_submodules_config" {
      for_each = var.fetch_git_submodules ? [""] : []
      content {
        fetch_submodules = true
      }
    }
  }

  dynamic "vpc_config" {
    for_each = length(var.vpc_config) > 0 ? [""] : []
    content {
      vpc_id             = lookup(var.vpc_config, "vpc_id", null)
      subnets            = lookup(var.vpc_config, "subnets", null)
      security_group_ids = lookup(var.vpc_config, "security_group_ids", null)
    }
  }

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.vpc_subnet_ids
    security_group_ids = var.vpc_security_group_ids
  }

  tags = module.label.tags

  dynamic "logs_config" {
    for_each = length(var.logs_config) > 0 ? [""] : []
    content {
      dynamic "cloudwatch_logs" {
        for_each = contains(keys(var.logs_config), "cloudwatch_logs") ? { key = var.logs_config["cloudwatch_logs"] } : {}
        content {
          status      = lookup(cloudwatch_logs.value, "status", null)
          group_name  = lookup(cloudwatch_logs.value, "group_name", null)
          stream_name = lookup(cloudwatch_logs.value, "stream_name", null)
        }
      }

      dynamic "s3_logs" {
        for_each = contains(keys(var.logs_config), "s3_logs") ? { key = var.logs_config["s3_logs"] } : {}
        content {
          status              = lookup(s3_logs.value, "status", null)
          location            = lookup(s3_logs.value, "location", null)
          encryption_disabled = lookup(s3_logs.value, "encryption_disabled", null)
        }
      }
    }
  }

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.vpc_subnet_ids
    security_group_ids = var.vpc_security_group_ids
  }

  tags = module.label.tags
}

