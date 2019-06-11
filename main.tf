data "aws_caller_identity" "default" {}

data "aws_region" "default" {}

resource "aws_s3_bucket" "cache_bucket" {
  count         = "${var.enabled && var.cache_enabled ? 1 : 0}"
  bucket        = "${local.cache_bucket_name_normalised}"
  acl           = "private"
  force_destroy = true
  tags          = "${module.label.tags}"

  lifecycle_rule {
    id      = "codebuildcache"
    enabled = true

    prefix = "/"
    tags   = "${module.label.tags}"

    expiration {
      days = "${var.cache_expiration_days}"
    }
  }
}

resource "random_string" "bucket_prefix" {
  length  = 12
  number  = false
  upper   = false
  special = false
  lower   = true
}

locals {
  # Handle quoted and unquoted booleen values
  cache_bucket_suffix_enabled = "${var.cache_bucket_suffix_enabled == true ? 1 : var.cache_bucket_suffix_enabled == "true"}"
  cache_bucket_name           = "${format("%v%v",module.label.id, local.cache_bucket_suffix_enabled ? "-${random_string.bucket_prefix.result}" : "" )}"

  ## Clean up the bucket name to use only hyphens, and trim its length to 63 characters.
  ## As per https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html
  cache_bucket_name_normalised = "${format("%.63v", join("-", split("_", lower(local.cache_bucket_name))))}"

  ## This is the magic where a map of a list of maps is generated
  ## and used to conditionally add the cache bucket option to the
  ## aws_codebuild_project
  cache_def = {
    "with" = [{
      type     = "S3"
      location = "${var.enabled && var.cache_enabled ? join("", aws_s3_bucket.cache_bucket.*.bucket) : "none" }"
    }]

    "without" = []
  }

  # Handle quoted and unquoted booleen values
  cache_enabled = "${var.cache_enabled == true ? 1 : var.cache_enabled == "true"}"

  # Final Map Selected from above
  cache = "${local.cache_def[local.cache_enabled ? "with" : "without" ]}"
}

resource "aws_iam_role" "default" {
  count              = "${var.enabled ? 1 : 0}"
  name               = "${module.label.id}"
  assume_role_policy = "${data.aws_iam_policy_document.role.json}"
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
  count  = "${var.enabled ? 1 : 0}"
  name   = "${module.label.id}"
  path   = "/service-role/"
  policy = "${data.aws_iam_policy_document.permissions.json}"
}

resource "aws_iam_policy" "default_cache_bucket" {
  count  = "${var.enabled && var.cache_enabled ? 1 : 0}"
  name   = "${module.label.id}-cache-bucket"
  path   = "/service-role/"
  policy = "${data.aws_iam_policy_document.permissions_cache_bucket.json}"
}

data "aws_iam_policy_document" "permissions" {
  statement {
    sid = ""

    actions = [
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
    ]

    effect = "Allow"

    resources = [
      "${var.default_role_resources}",
    ]
  }
}

data "aws_iam_policy_document" "permissions_cache_bucket" {
  count = "${var.enabled == "true" && var.cache_enabled == "true" ? 1 : 0}"

  statement {
    sid = ""

    actions = [
      "s3:*",
    ]

    effect = "Allow"

    resources = [
      "${aws_s3_bucket.cache_bucket.arn}",
      "${aws_s3_bucket.cache_bucket.arn}/*",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = "${var.enabled ? 1 : 0}"
  policy_arn = "${aws_iam_policy.default.arn}"
  role       = "${aws_iam_role.default.id}"
}

resource "aws_iam_role_policy_attachment" "default_cache_bucket" {
  count      = "${var.enabled && var.cache_enabled ? 1 : 0}"
  policy_arn = "${element(aws_iam_policy.default_cache_bucket.*.arn, count.index)}"
  role       = "${aws_iam_role.default.id}"
}

resource "null_resource" "env" {
  # This is to create a dependancy that will be waited on by the codebuild project
  count = "${var.environment_variable_count}"

  triggers {
    name  = "${lookup(var.environment_variables[count.index], "name", "MISSING")}"
    value = "${lookup(var.environment_variables[count.index], "value", "MISSING")}"
  }
}

locals {
  ## Provide a default description based on the label module.
  description = "${var.description == "" ? title(replace(module.label.id, module.label.delimiter, " ")) : var.description}"
}

resource "aws_codebuild_project" "default" {
  count         = "${var.enabled == "true" ? 1 : 0}"
  name          = "${module.label.id}"
  description   = "${local.description}"
  service_role  = "${aws_iam_role.default.arn}"
  badge_enabled = "${var.badge_enabled}"
  build_timeout = "${var.build_timeout}"

  artifacts {
    type = "${var.artifact_type}"
  }

  # The cache as a list with a map object inside.
  cache = ["${local.cache}"]

  environment {
    compute_type    = "${var.build_compute_type}"
    image           = "${var.build_image}"
    type            = "LINUX_CONTAINER"
    privileged_mode = "${var.privileged_mode}"

    environment_variable = [{
      "name"  = "AWS_REGION"
      "value" = "${signum(length(var.aws_region)) == 1 ? var.aws_region : data.aws_region.default.name}"
    },
      {
        "name"  = "AWS_ACCOUNT_ID"
        "value" = "${signum(length(var.aws_account_id)) == 1 ? var.aws_account_id : data.aws_caller_identity.default.account_id}"
      },
      {
        "name"  = "IMAGE_REPO_NAME"
        "value" = "${signum(length(var.image_repo_name)) == 1 ? var.image_repo_name : "UNSET"}"
      },
      {
        "name"  = "IMAGE_TAG"
        "value" = "${signum(length(var.image_tag)) == 1 ? var.image_tag : "latest"}"
      },
      {
        "name"  = "STAGE"
        "value" = "${signum(length(var.stage)) == 1 ? var.stage : "UNSET"}"
      },
      {
        "name"  = "GITHUB_TOKEN"
        "value" = "${signum(length(var.github_token)) == 1 ? var.github_token : "UNSET"}"
      },
      ["${var.environment_variables}"],
    ]
  }

  source {
    buildspec           = "${var.buildspec}"
    type                = "${var.source_type}"
    location            = "${var.source_location}"
    report_build_status = "${var.report_build_status}"
  }

  tags       = "${module.label.tags}"
  depends_on = ["null_resource.env"]
}
