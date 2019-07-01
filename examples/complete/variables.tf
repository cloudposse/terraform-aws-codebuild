variable "region" {
  type = string
}

variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
}

variable "name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "environment_variables" {
  type = list(object(
    {
      name  = string
      value = string
  }))

  default = [
    {
      name  = "NO_ADDITIONAL_BUILD_VARS"
      value = "TRUE"
  }]

  description = "A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "A boolean to enable/disable resource creation"
}

variable "cache_enabled" {
  type        = bool
  default     = true
  description = "If cache_enabled is true, create an S3 bucket for storing codebuild cache inside"
}

variable "cache_expiration_days" {
  default     = 7
  description = "How many days should the build cache be kept"
}

variable "cache_bucket_suffix_enabled" {
  type        = bool
  default     = false
  description = "The cache bucket generates a random 13 character string to generate a unique bucket name. If set to false it uses terraform-null-label's id value"
}

variable "badge_enabled" {
  type        = bool
  default     = false
  description = "Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled"
}

variable "build_image" {
  type        = string
  default     = "aws/codebuild/standard:2.0"
  description = "Docker image for build environment, e.g. 'aws/codebuild/standard:2.0' or 'aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0'. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html"
}

variable "build_compute_type" {
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
  description = "Instance type of the build instance"
}

variable "build_timeout" {
  default     = 60
  description = "How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed"
}

variable "buildspec" {
  type        = string
  default     = ""
  description = "Optional buildspec declaration to use for building the project"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit', 'XYZ')`"
}

variable "privileged_mode" {
  type        = bool
  default     = false
  description = "(Optional) If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images"
}

variable "source_type" {
  type        = string
  default     = "CODEPIPELINE"
  description = "The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET or S3"
}

variable "source_location" {
  type        = string
  default     = ""
  description = "The location of the source code from git or s3."
}

variable "artifact_type" {
  type        = string
  default     = "CODEPIPELINE"
  description = "The build output artifact's type. Valid values for this parameter are: CODEPIPELINE, NO_ARTIFACTS or S3"
}

variable "report_build_status" {
  type        = bool
  default     = false
  description = "Set to true to report the status of a build's start and finish to your source provider. This option is only valid when the source_type is BITBUCKET or GITHUB"
}
