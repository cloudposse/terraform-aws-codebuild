output "project_name" {
  value = "${aws_codebuild_project.default.*.name}"
}

output "project_id" {
  value = "${aws_codebuild_project.default.*.id}"
}

output "role_arn" {
  value = "${aws_iam_role.default.*.id}"
}

output "cache_bucket_name" {
  value = "${var.enabled == "true" && var.cache_enabled == "true" ? aws_s3_bucket.cache_bucket.0.bucket : "UNSET" }"
}
