locals {
  default_envvars = [
    {
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
    }
  ]
}