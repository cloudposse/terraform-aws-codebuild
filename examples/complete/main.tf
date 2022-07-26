provider "aws" {
  region = var.region
}

provider "awsutils" {
  region = var.region
}

module "codebuild" {
  source                      = "../../"
  description                 = "This is my awesome CodeBuild project"
  concurrent_build_limit      = 10
  cache_bucket_suffix_enabled = var.cache_bucket_suffix_enabled
  environment_variables       = var.environment_variables
  cache_expiration_days       = var.cache_expiration_days
  cache_type                  = var.cache_type

  context = module.this.context
}
