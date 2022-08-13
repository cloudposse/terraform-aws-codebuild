module "build" {
  source = "cloudposse/codebuild/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "1.0"
  namespace           = "babelhealth"
  stage               = "development"
  name                = "test"

  # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
  # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html
  build_image         = "aws/codebuild/standard:6.0"
  build_compute_type  = "BUILD_GENERAL1_MEDIUM"
  build_timeout       = 60

  # These attributes are optional, used as ENV variables when building Docker images and pushing them to ECR
  # For more info:
  # http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html
  # https://www.terraform.io/docs/providers/aws/r/codebuild_project.html

  privileged_mode     = true
  aws_region          = "us-east-1"
  aws_account_id      = "350343013187"
  image_repo_name     = "babelhealth"
  image_tag           = "latest"

  # Optional extra environment variables
  environment_variables = [
    {
      name  = "_PROFILE_"
      value = "Development"
      type  = "PLAINTEXT"
    }
  ]
}