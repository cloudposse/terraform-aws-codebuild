terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.20.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4"
    }
  }
}
