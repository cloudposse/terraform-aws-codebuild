output "project_name" {
  value = "${aws_codebuild_project.default.name}"
}

output "project_id" {
  value = "${aws_codebuild_project.default.id}"
}
