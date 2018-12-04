variable "tags" {
  description = "[Required unless var.context used] Default tags."
  type        = "map"
  default     = {}
}

variable "namespace" {
  type        = "string"
  default     = "global"
  description = "Namespace, which could be your organization name, e.g. 'cp' or 'cloudposse'"
}

variable "stage" {
  type        = "string"
  default     = "global"
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
}

variable "name" {
  type        = "string"
  default     = "codebuild"
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "environment" {
  description = "The environment name if not using stage"
  default     = ""
}

variable "attributes" {
  type        = "list"
  description = "Any extra attributes for tagging or defining these resources."
  default     = []
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "context" {
  type        = "map"
  description = "[Optional] The context output from a label module to pass to the label modules within this module"
  default     = {}
}

# Define composite variables for resources
module "label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.5.3"
  attributes  = ["${var.attributes}"]
  namespace   = "${var.namespace}"
  environment = "${var.environment}"
  name        = "${var.name}"
  tags        = "${var.tags}"
  context     = "${var.context}"
}
