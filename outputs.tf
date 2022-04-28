output "project_name" {
  description = "Project name"
  value       = join("", aws_codebuild_project.default.*.name)
}

output "project_id" {
  description = "Project ID"
  value       = join("", aws_codebuild_project.default.*.id)
}

output "role_id" {
  description = "IAM Role ID"
  value       = join("", aws_iam_role.default.*.id)
}

output "role_arn" {
  description = "IAM Role ARN"
  value       = join("", aws_iam_role.default.*.arn)
}

output "cache_bucket_name" {
  description = "Cache S3 bucket name"
  value       = module.this.enabled && local.s3_cache_enabled ? join("", aws_s3_bucket.cache_bucket.*.bucket) : "UNSET"
}

output "cache_bucket_arn" {
  description = "Cache S3 bucket ARN"
  value       = module.this.enabled && local.s3_cache_enabled ? join("", aws_s3_bucket.cache_bucket.*.arn) : "UNSET"
}

output "badge_url" {
  description = "The URL of the build badge when badge_enabled is enabled"
  value       = join("", aws_codebuild_project.default.*.badge_url)
}

output "project_arn" {
  description = "Project ARN"
  value       = join("", aws_codebuild_project.default.*.arn)
}
