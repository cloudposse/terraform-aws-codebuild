# Codebuild
output "project_name" {
  description = "Project name"
  value       = module.build.project_name
}

output "project_id" {
  description = "Project ID"
  value       = module.build.project_id
}

output "role_id" {
  description = "IAM Role ID"
  value       = module.build.role_id
}

output "role_arn" {
  description = "IAM Role ARN"
  value       = module.build.role_arn
}

output "cache_bucket_name" {
  description = "Cache S3 bucket name"
  value       = module.build.cache_bucket_name
}

output "cache_bucket_arn" {
  description = "Cache S3 bucket ARN"
  value       = module.build.cache_bucket_arn
}

output "badge_url" {
  description = "The URL of the build badge when badge_enabled is enabled"
  value       = module.build.badge_url
}

# ECR

output "repository_arn" {
  # Full ARN of the repository.
  value = aws_ecr_repository.ecr_repo.arn
}

output "repository_image_full_name_tag" {
  # The full name of the container image as docker style "name:tag".
  value =  "${aws_ecr_repository.ecr_repo.repository_url}:${local.image_tag}"

}

output "repository_name" {
  # The name of the repository.
  value = aws_ecr_repository.ecr_repo.name
}

output "repository_name_tag" {
  # The tag of the container image.
  value = local.image_tag
}

output "registry_id" {
  # The registry ID where the repository was created.
  value = aws_ecr_repository.ecr_repo.registry_id
}

output "repository_url" {
  # The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName).
  value = aws_ecr_repository.ecr_repo.repository_url
}



