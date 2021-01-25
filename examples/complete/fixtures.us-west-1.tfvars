region = "us-west-1"

namespace = "eg"

stage = "test"

name = "cedebuild-test"

cache_bucket_suffix_enabled = false

environment_variables = [
  {
    name  = "APP_URL"
    value = "https://app.example.com"
  },
  {
    name  = "COMPANY_NAME"
    value = "Cloud Posse"
  },
  {
    name  = "TIME_ZONE"
    value = "America/Los_Angeles"

  }
]

cache_expiration_days = 7

cache_type = "S3"

mfa_delete = false