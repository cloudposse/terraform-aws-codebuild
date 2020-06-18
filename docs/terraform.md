## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| artifact_type | The build output artifact's type. Valid values for this parameter are: CODEPIPELINE, NO_ARTIFACTS or S3 | string | `CODEPIPELINE` | no |
| attributes | Additional attributes (e.g. `policy` or `role`) | list(string) | `<list>` | no |
| aws_account_id | (Optional) AWS Account ID. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | string | `` | no |
| aws_region | (Optional) AWS Region, e.g. us-east-1. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | string | `` | no |
| badge_enabled | Generates a publicly-accessible URL for the projects build badge. Available as badge_url attribute when enabled | bool | `false` | no |
| build_compute_type | Instance type of the build instance | string | `BUILD_GENERAL1_SMALL` | no |
| build_image | Docker image for build environment, e.g. 'aws/codebuild/standard:2.0' or 'aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0'. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html | string | `aws/codebuild/standard:2.0` | no |
| build_timeout | How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed | string | `60` | no |
| build_type | The type of build environment, e.g. 'LINUX_CONTAINER' or 'WINDOWS_CONTAINER' | string | `LINUX_CONTAINER` | no |
| buildspec | Optional buildspec declaration to use for building the project | string | `` | no |
| cache_bucket_suffix_enabled | The cache bucket generates a random 13 character string to generate a unique bucket name. If set to false it uses terraform-null-label's id value. It only works when cache_type is 'S3 | bool | `true` | no |
| cache_expiration_days | How many days should the build cache be kept. It only works when cache_type is 'S3' | string | `7` | no |
| cache_type | The type of storage that will be used for the AWS CodeBuild project cache. Valid values: NO_CACHE, LOCAL, and S3.  Defaults to NO_CACHE.  If cache_type is S3, it will create an S3 bucket for storing codebuild cache inside | string | `NO_CACHE` | no |
| delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | string | `-` | no |
| enabled | A boolean to enable/disable resource creation | bool | `true` | no |
| environment_variables | A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build | object | `<list>` | no |
| extra_permissions | List of action strings which will be added to IAM service account permissions. | list | `<list>` | no |
| fetch_git_submodules | If set to true, fetches Git submodules for the AWS CodeBuild build project. | bool | `false` | no |
| git_clone_depth | Truncate git history to this many commits. | number | `null` | no |
| github_token | (Optional) GitHub auth token environment variable (`GITHUB_TOKEN`) | string | `` | no |
| image_repo_name | (Optional) ECR repository name to store the Docker image built by this module. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | string | `UNSET` | no |
| image_tag | (Optional) Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | string | `latest` | no |
| local_cache_modes | Specifies settings that AWS CodeBuild uses to store and reuse build dependencies. Valid values: LOCAL_SOURCE_CACHE, LOCAL_DOCKER_LAYER_CACHE, and LOCAL_CUSTOM_CACHE | list(string) | `<list>` | no |
| logs_config | Configuration for the builds to store log data to CloudWatch or S3. | any | `<map>` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | string | - | yes |
| namespace | Namespace, which could be your organization name, e.g. 'eg' or 'cp' | string | `` | no |
| private_repository | Set to true to login into private repository with credentials supplied in source_credential variable. | bool | `false` | no |
| privileged_mode | (Optional) If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images | bool | `false` | no |
| report_build_status | Set to true to report the status of a build's start and finish to your source provider. This option is only valid when the source_type is BITBUCKET or GITHUB | bool | `false` | no |
| source_credential_auth_type | The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. | string | `PERSONAL_ACCESS_TOKEN` | no |
| source_credential_server_type | The source provider used for this project. | string | `GITHUB` | no |
| source_credential_token | For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password. | string | `` | no |
| source_credential_user_name | The Bitbucket username when the authType is BASIC_AUTH. This parameter is not valid for other types of source providers or connections. | string | `` | no |
| source_location | The location of the source code from git or s3 | string | `` | no |
| source_type | The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET or S3 | string | `CODEPIPELINE` | no |
| source_version | A version of the build input to be built for this project. If not specified, the latest version is used. | string | `` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', or 'test' | string | `` | no |
| tags | Additional tags (e.g. `map('BusinessUnit', 'XYZ')` | map(string) | `<map>` | no |
| vpc_config | Configuration for the builds to run inside a VPC. | any | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| badge_url | The URL of the build badge when badge_enabled is enabled |
| cache_bucket_arn | Cache S3 bucket ARN |
| cache_bucket_name | Cache S3 bucket name |
| project_id | Project ID |
| project_name | Project name |
| role_arn | IAM Role ARN |
| role_id | IAM Role ID |

