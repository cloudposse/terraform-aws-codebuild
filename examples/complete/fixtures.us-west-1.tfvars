region = "us-west-1"

namespace = "eg"

stage = "test"

name = "cedebuild-test"

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
