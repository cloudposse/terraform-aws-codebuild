data "aws_caller_identity" "default" {}

data "aws_region" "default" {
  current = true
}

# Define composite variables for resources
module "label" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.2.1"
  namespace  = "${var.namespace}"
  name       = "${var.name}"
  stage      = "${var.stage}"
  delimiter  = "${var.delimiter}"
  attributes = "${var.attributes}"
  tags       = "${var.tags}"
}

resource "aws_iam_role" "default" {
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
  name   = "${module.label.id}"
  path   = "/service-role/"
  policy = "${data.aws_iam_policy_document.permissions.json}"
}

data "aws_iam_policy_document" "permissions" {
  statement {
    sid = ""

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "default" {
  policy_arn = "${aws_iam_policy.default.arn}"
  role       = "${aws_iam_role.default.id}"
}

resource "aws_codebuild_project" "default" {
  name         = "${module.label.id}"
  service_role = "${aws_iam_role.default.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "${var.build_compute_type}"
    image           = "${var.build_image}"
    type            = "LINUX_CONTAINER"
    privileged_mode = "${var.privileged_mode}"

    environment_variable {
      "name"  = "AWS_REGION"
      "value" = "${signum(length(var.aws_region)) == 1 ? var.aws_region : data.aws_region.default.name}"
    }

    environment_variable {
      "name"  = "AWS_ACCOUNT_ID"
      "value" = "${signum(length(var.aws_account_id)) == 1 ? var.aws_account_id : data.aws_caller_identity.default.account_id}"
    }

    environment_variable {
      "name"  = "IMAGE_REPO_NAME"
      "value" = "${var.image_repo_name}"
    }

    environment_variable {
      "name"  = "IMAGE_TAG"
      "value" = "${var.image_tag}"
    }
  }

  source {
    buildspec = "${var.buildspec}"
    type      = "CODEPIPELINE"
  }

  tags = "${module.label.tags}"
}
