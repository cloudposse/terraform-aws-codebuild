region = "us-east-2"

namespace = "eg"

stage = "test"

name = "codebuild-test"

environment_variables = [
  {
    name  = "APP_URL"
    value = "https://app.example.com"
    type  = "PLAINTEXT"
  },
  {
    name  = "COMPANY_NAME"
    value = "Cloud Posse"
    type  = "PLAINTEXT"
  },
  {
    name  = "TIME_ZONE"
    value = "America/Los_Angeles"
    type  = "PLAINTEXT"
  }
]

cache_expiration_days = 7

cache_type = "S3"
