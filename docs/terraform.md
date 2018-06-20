
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attributes |  | list | `<list>` | no |
| aws_account_id | (Optional) AWS Account ID. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | string | `` | no |
| aws_region | (Optional) AWS Region, e.g. us-east-1. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | string | `` | no |
| build_compute_type |  | string | `BUILD_GENERAL1_SMALL` | no |
| build_image | Docker image for build environment, e.g. 'aws/codebuild/docker:1.12.1' or 'aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0'. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html | string | `aws/codebuild/docker:1.12.1` | no |
| buildspec | Optional buildspec declaration to use for building the project | string | `` | no |
| cache_bucket_suffix_enabled | The cache bucket generates a random 13 character string to generate a unique bucket name. If set to false it uses terraform-null-label's id value | string | `true` | no |
| cache_enabled | If cache_enabled is true, create an S3 bucket for storing codebuild cache inside | string | `true` | no |
| cache_expiration_days | How many days should the build cache be kept. | string | `7` | no |
| delimiter |  | string | `-` | no |
| enabled | A boolean to enable/disable resource creation. | string | `true` | no |
| environment_variables | A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build. | list | `<list>` | no |
| github_token | (Optional) GitHub auth token environment variable (`GITHUB_TOKEN`) | string | `` | no |
| image_repo_name | (Optional) ECR repository name to store the Docker image built by this module. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | string | `UNSET` | no |
| image_tag | (Optional) Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | string | `latest` | no |
| name |  | string | `codebuild` | no |
| namespace |  | string | `global` | no |
| privileged_mode | (Optional) If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images | string | `false` | no |
| stage |  | string | `default` | no |
| tags |  | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| cache_bucket_name |  |
| project_id |  |
| project_name |  |
| role_arn |  |

