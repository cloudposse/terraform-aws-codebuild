provider "aws" {
  region = var.region
}

module "codebuild" {
  source                = "../../"
  namespace             = var.namespace
  stage                 = var.stage
  name                  = var.name
  environment_variables = var.environment_variables
}
