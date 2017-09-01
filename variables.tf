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
  default = false
}

variable "aws_region" {
  type    = "string"
  default = ""
}

variable "aws_account_id" {
  type    = "string"
  default = ""
}

variable "image_repo_name" {
  type    = "string"
  default = ""
}

variable "image_tag" {
  type    = "string"
  default = ""
}
