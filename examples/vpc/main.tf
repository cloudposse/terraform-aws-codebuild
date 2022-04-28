provider "aws" {
  region = var.region
}

module "vpc" {
  source     = "cloudposse/vpc/aws"
  version    = "0.21.1"
  cidr_block = var.vpc_cidr_block

  context = module.this.context
}

module "subnets" {
  source               = "cloudposse/dynamic-subnets/aws"
  version              = "0.38.0"
  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = true
  nat_instance_enabled = false

  context = module.this.context
}

module "codebuild" {
  source                      = "../../"
  cache_bucket_suffix_enabled = var.cache_bucket_suffix_enabled
  environment_variables       = var.environment_variables
  cache_expiration_days       = var.cache_expiration_days
  cache_type                  = var.cache_type

  vpc_config = {
    vpc_id = module.vpc.vpc_id

    subnets = module.subnets.private_subnet_ids

    security_group_ids = [
      module.vpc.vpc_default_security_group_id
    ]
  }

  context = module.this.context
}
