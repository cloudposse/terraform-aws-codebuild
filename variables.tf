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
