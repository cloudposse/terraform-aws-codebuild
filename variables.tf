variable "namespace" {
  default = "global"
}

variable "stage" {
  default = "default"
}

variable "name" {
  default = "codebuild"
}

variable "environment_variables" {
  type = "list"

  default = [{
    "name"  = "NO_ADDITIONAL_BUILD_VARS"
    "value" = "TRUE"
  }]

  description = "A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build."
}

variable "cache_enabled" {
  default     = "true"
  description = "If cache is true, create an S3 bucket for storing codebuild cache inside"
}

variable "cache_expiration_days" {
  default     = "7"
  description = "How many days should the build cache be kept."
}

variable "cache_bucket_suffix_enabled" {
  default     = "true"
  description = "The cache bucket generates a random 13 character string to generate a unique bucket name. If set to false it uses terraform-null-label's id value"
}

variable "build_image" {
  default     = "aws/codebuild/docker:1.12.1"
  description = "Docker image for build environment, e.g. 'aws/codebuild/docker:1.12.1' or 'aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0'. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html"
}

variable "build_compute_type" {
  default = "BUILD_GENERAL1_SMALL"
}

variable "buildspec" {
  default     = ""
  description = "Optional buildspec declaration to use for building the project"
}

variable "delimiter" {
  type    = "string"
  default = "-"
}

variable "attributes" {
  type    = "list"
  default = []
}

variable "tags" {
  type    = "map"
  default = {}
}

variable "privileged_mode" {
  default     = "false"
  description = "(Optional) If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images"
}

variable "github_token" {
  default     = ""
  description = "(Optional) GitHub auth token environment variable (`GITHUB_TOKEN`)"
}

variable "aws_region" {
  type        = "string"
  default     = ""
  description = "(Optional) AWS Region, e.g. us-east-1. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "aws_account_id" {
  type        = "string"
  default     = ""
  description = "(Optional) AWS Account ID. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "image_repo_name" {
  type        = "string"
  default     = "UNSET"
  description = "(Optional) ECR repository name to store the Docker image built by this module. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "image_tag" {
  type        = "string"
  default     = "latest"
  description = "(Optional) Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}
