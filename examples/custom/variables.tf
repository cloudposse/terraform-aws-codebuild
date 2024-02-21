variable "region" {
  type        = string
  description = "AWS region"
}

variable "environment_variables" {
  type = list(object(
    {
      name  = string
      value = string
      type  = string
  }))

  default = [
    {
      name  = "NO_ADDITIONAL_BUILD_VARS"
      value = "TRUE"
      type  = "PLAINTEXT"
  }]

  description = "A list of maps, that contain the keys 'name', 'value', and 'type' to be used as additional environment variables for the build. Valid types are 'PLAINTEXT', 'PARAMETER_STORE', or 'SECRETS_MANAGER'"
}

variable "cache_expiration_days" {
  type        = number
  description = "How many days should the build cache be kept. It only works when cache_type is 'S3'"
}

variable "cache_bucket_suffix_enabled" {
  type        = bool
  description = "The cache bucket generates a random 13 character string to generate a unique bucket name. If set to false it uses terraform-null-label's id value"
}

variable "cache_type" {
  type        = string
  description = "The type of storage that will be used for the AWS CodeBuild project cache. Valid values: NO_CACHE, LOCAL, and S3.  Defaults to NO_CACHE.  If cache_type is S3, it will create an S3 bucket for storing codebuild cache inside"
}

variable "default_permissions_enabled" {
  type        = bool
  default     = true
  description = "When 'true' default base iam permissions to get up and running with codebuild are attached. Those who want a least priveleged policy can instead set to `false` and use the `custom policy` variable."
}

variable "custom_policy" {
  type        = list(string)
  description = "JSON encoded IAM policy to add to the IAM service account permissions."
  default     = []
}
