region = "us-east-2"

namespace = "eg"

stage = "test"

name = "codebuild-custom-policy"

cache_bucket_suffix_enabled = true

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

default_permissions_enabled = false
custom_policy               = ["{\"Statement\":[{\"Action\":[\"secretsmanager:GetSecretValue\"],\"Condition\":{\"StringLike\":{\"aws:ResourceTag/used-by\":\"*my-team*\"}},\"Effect\":\"Allow\",\"Resource\":[\"arn:aws:secretsmanager:us-east-2:*:secret:some-secret-value\",\"arn:aws:secretsmanager:us-east-2:*:secret:some-other-secret-value\"],\"Sid\":\"ReadSecrets\"},{\"Action\":[\"logs:CreateLogGroup\",\"logs:CreateLogStream\",\"logs:PutLogEvents\"],\"Effect\":\"Allow\",\"Resource\":[\"*\"],\"Sid\":\"LoggingForTesting\"}],\"Version\":\"2012-10-17\"}"]
