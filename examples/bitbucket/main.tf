provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}


locals {
  repository_name = var.repository_name
  build_name      = local.repository_name
  image_tag       = var.image_tag
  tagPrefixList   = concat(var.tagPrefixList, ["ts"])
}

resource "null_resource" "codebuild_provisioner" {
  triggers = {
    value = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = "./start-build.sh ${module.build.project_name} ${var.aws_profile} ${var.aws_region} false 120 60 1 15 6"
    # Arguments
    # <codebuild-project-name> <aws-profile> <aws-region> <print-dots> <initial-timeout> <update-timeout> <sleep-interval> <init-wait-time> <max-retry-count>
  }

  depends_on = [module.build, aws_ecr_repository.ecr_repo]
}