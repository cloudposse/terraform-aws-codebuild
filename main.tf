# Define composite variables for resources
module "label" {
  source    = "git::https://github.com/cloudposse/tf_label.git"
  namespace = "${var.namespace}"
  name      = "${var.name}"
  stage     = "${var.stage}"
}

resource "aws_iam_role" "default" {
  name = "${module.label.id}"
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
  name = "${module.label.id}"
  path = "/service-role/"
  policy = "${data.aws_iam_policy_document.logs.json}"
}

data "aws_iam_policy_document" "logs" {
  statement {
    sid = ""

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    effect = "Allow"

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy_attachment" "default" {
  name = "${module.label.id}"
  policy_arn = "${aws_iam_policy.default.arn}"
  roles      = ["${aws_iam_role.default.id}"]
}

resource "aws_codebuild_project" "default" {
  name = "${module.label.id}"
  service_role = "${aws_iam_role.default.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "2"
    type         = "LINUX_CONTAINER"
  }

  source {
    type     = "CODEPIPELINE"
  }

  tags = "${module.label.tags}"
}
