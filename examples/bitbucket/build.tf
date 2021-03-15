
module "build" {
  source = "../.."

  namespace = var.namespace
  stage     = var.stage
  name      = local.build_name

  # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
  build_image        = var.build_image
  build_compute_type = var.build_compute_type
  build_timeout      = var.build_timeout
  buildspec          = var.buildspec
  privileged_mode    = var.privileged_mode

  # Target repository (ECS)
  image_repo_name = aws_ecr_repository.ecr_repo.name
  image_tag       = local.image_tag

  # Extra permissions
  extra_permissions = var.extra_permissions

  # environment_variables
  aws_region            = var.aws_region
  aws_account_id        = var.aws_account_id
  environment_variables = var.environment_variables

  # Source repository
  artifact_type   = var.artifact_type
  source_type     = var.source_type
  source_location = var.source_location
  git_clone_depth = var.git_clone_depth

  # Branch name
  source_version = var.source_version != "" ? var.source_version : null

  # Repository Credentials
  private_repository            = var.private_repository
  source_credential_token       = var.source_credential_token
  source_credential_user_name   = var.source_credential_user_name
  source_credential_auth_type   = var.source_credential_auth_type
  source_credential_server_type = var.source_credential_server_type

  # Cache
  cache_expiration_days       = var.cache_expiration_days
  cache_bucket_suffix_enabled = var.cache_bucket_suffix_enabled
  cache_type                  = var.cache_type
  local_cache_modes           = var.local_cache_modes

  # Other
  badge_enabled = var.badge_enabled
  attributes    = var.attributes
  tags          = var.tags

}
