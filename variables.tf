variable "namespace" {
  default = "global"
}

variable "stage" {
  default = "default"
}

variable "name" {
  default = "codebuild"
}

variable "image" {
  default = "alpine"
}

variable "instance_size" {
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
  default     = false
  description = "(Optional, used when building Docker images). If set to true, enables running the Docker daemon inside a Docker container."
}

variable "aws_region" {
  type        = "string"
  default     = ""
  description = "(Optional, used when building Docker images and pushing them to ECR). AWS Region for the ECR repository, e.g. us-east-1. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "aws_account_id" {
  type        = "string"
  default     = ""
  description = "(Optional, used when building Docker images and pushing them to ECR). AWS Account ID that owns the ECR repository. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "image_repo_name" {
  type        = "string"
  default     = ""
  description = "(Optional, used when building Docker images and pushing them to ECR). ECR repository name to store Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "image_tag" {
  type        = "string"
  default     = ""
  description = "(Optional, used when building Docker images and pushing them to ECR). Docker image tag in the ECR repository, e.g. 'latest'. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}
