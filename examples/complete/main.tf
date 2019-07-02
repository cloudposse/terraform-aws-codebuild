provider "aws" {
  region = var.region
}

module "codebuild" {
  source                      = "../../"
  namespace                   = var.namespace
  stage                       = var.stage
  name                        = var.name
  cache_enabled               = var.cache_enabled
  cache_bucket_suffix_enabled = var.cache_bucket_suffix_enabled
  environment_variables       = var.environment_variables
}
