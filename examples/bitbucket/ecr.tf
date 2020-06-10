resource "aws_ecr_repository" "ecr_repo" {
  name                 = local.repository_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

resource "aws_ecr_lifecycle_policy" "lifecycle" {
  count = var.life_cycle_policy ? 1 : 0
  repository = aws_ecr_repository.ecr_repo.name
  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last ${var.keep_tagged_last_n_images} images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["${join("\",\"",local.tagPrefixList)}"],
                "countType": "imageCountMoreThan",
                "countNumber": ${var.keep_tagged_last_n_images}
            },
            "action": {
                "type": "expire"
            }
        },
        {
            "rulePriority": 2,
            "description": "Expire images older than ${var.expire_untagged_older_than_n_days} days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": ${var.expire_untagged_older_than_n_days}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}