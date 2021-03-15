
variable "aws_profile" {
  type        = string
  default     = ""
  description = "(Optional) AWS Profile name as used in AWS credentials file."
}

# ECR Vars
variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = ""
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository.Must be one of MUTABLE or IMMUTABLE."
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  type        = bool
  default     = true
}

variable "life_cycle_policy" {
  description = "Enables lifecycle policy"
  type        = bool
  default     = true
}

variable "keep_tagged_last_n_images" {
  description = "Keeps only n number of images in the repository."
  type        = number
  default     = 30
}

variable "tagPrefixList" {
  description = "Selection criteria for tagged images lifecycle policy."
  type        = list(string)
  default     = ["v"]
}

variable "expire_untagged_older_than_n_days" {
  description = "Deletes untagged images older than n days."
  type        = number
  default     = 15
}

variable "run_build_token" {
  description = "Change it to initiate run."
  type        = string
  default     = ""
}


# build vars

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
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

variable "cache_expiration_days" {
  default     = 7
  description = "How many days should the build cache be kept. It only works when cache_type is 'S3'"
}

variable "cache_bucket_suffix_enabled" {
  type        = bool
  default     = true
  description = "The cache bucket generates a random 13 character string to generate a unique bucket name. If set to false it uses terraform-null-label's id value. It only works when cache_type is 'S3"
}

variable "cache_type" {
  type        = string
  default     = "NO_CACHE"
  description = "The type of storage that will be used for the AWS CodeBuild project cache. Valid values: NO_CACHE, LOCAL, and S3.  Defaults to NO_CACHE.  If cache_type is S3, it will create an S3 bucket for storing codebuild cache inside"
}

variable "local_cache_modes" {
  type        = list(string)
  default     = []
  description = "Specifies settings that AWS CodeBuild uses to store and reuse build dependencies. Valid values: LOCAL_SOURCE_CACHE, LOCAL_DOCKER_LAYER_CACHE, and LOCAL_CUSTOM_CACHE"
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

variable "build_environment_type" {
  type        = string
  default     = "LINUX_CONTAINER"
  description = "The type of build environment to use for related builds. Available values are: LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER or ARM_CONTAINER."
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

variable "github_token" {
  type        = string
  default     = ""
  description = "(Optional) GitHub auth token environment variable (`GITHUB_TOKEN`)"
}

variable "aws_region" {
  type        = string
  default     = ""
  description = "(Optional) AWS Region, e.g. us-east-1. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "aws_account_id" {
  type        = string
  default     = ""
  description = "(Optional) AWS Account ID. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "image_repo_name" {
  type        = string
  default     = "UNSET"
  description = "(Optional) ECR repository name to store the Docker image built by this module. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "(Optional) Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html"
}

variable "source_type" {
  type        = string
  default     = "CODEPIPELINE"
  description = "The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET or S3"
}

variable "source_location" {
  type        = string
  default     = ""
  description = "The location of the source code from git or s3"
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

variable "git_clone_depth" {
  type        = number
  default     = null
  description = "Truncate git history to this many commits."
}

variable "private_repository" {
  type        = bool
  default     = false
  description = "Set to true to login into private repository with credentials supplied in source_credential variable."
}

variable "source_credential_auth_type" {
  type        = string
  default     = "PERSONAL_ACCESS_TOKEN"
  description = "The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository."
}

variable "source_credential_server_type" {
  type        = string
  default     = "GITHUB"
  description = "The source provider used for this project."
}

variable "source_credential_token" {
  type        = string
  default     = ""
  description = "For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password."
}

variable "source_credential_user_name" {
  type        = string
  default     = ""
  description = "The Bitbucket username when the authType is BASIC_AUTH. This parameter is not valid for other types of source providers or connections."
}

variable "source_version" {
  type        = string
  default     = ""
  description = "A version of the build input to be built for this project. If not specified, the latest version is used."
}

variable "fetch_git_submodules" {
  type        = bool
  default     = false
  description = "If set to true, fetches Git submodules for the AWS CodeBuild build project."
}

variable "vpc_config" {
  type        = any
  default     = {}
  description = "Configuration for the builds to run inside a VPC."
}

variable "logs_config" {
  type        = any
  default     = {}
  description = "Configuration for the builds to store log data to CloudWatch or S3."
}

variable "extra_permissions" {
  type        = list(any)
  default     = []
  description = "List of action strings which will be added to IAM service account permissions."
}

# Log tracker
variable "log_tracker" {
  type    = map(any)
  default = {}
}
