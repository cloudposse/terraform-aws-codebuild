provider "aws" {
  region = var.region
}

module "codebuild" {
  source                      = "../../"
  namespace                   = var.namespace
  stage                       = var.stage
  name                        = var.name
  cache_bucket_suffix_enabled = var.cache_bucket_suffix_enabled
  environment_variables       = var.environment_variables
  cache_expiration_days       = var.cache_expiration_days
  cache_type                  = var.cache_type
}
