output "project_name" {
  value = "${join("", aws_codebuild_project.default.*.name)}"
}

output "project_id" {
  value = "${join("", aws_codebuild_project.default.*.id)}"
}

output "role_arn" {
  value = "${join("", aws_iam_role.default.*.id)}"
}

output "cache_bucket_name" {
  value = "${var.enabled == "true" && var.cache_enabled == "true" ? join("", aws_s3_bucket.cache_bucket.*.bucket) : "UNSET" }"
}
