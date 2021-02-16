<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| aws | >= 2.0 |
| random | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.0 |
| random | >= 2.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_log\_bucket\_name | Name of the S3 bucket where s3 access log will be sent to | `string` | `""` | no |
| additional\_tag\_map | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| artifact\_location | Location of artifact. Applies only for artifact of type S3 | `string` | `""` | no |
| artifact\_type | The build output artifact's type. Valid values for this parameter are: CODEPIPELINE, NO\_ARTIFACTS or S3 | `string` | `"CODEPIPELINE"` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| aws\_account\_id | (Optional) AWS Account ID. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | `string` | `""` | no |
| aws\_region | (Optional) AWS Region, e.g. us-east-1. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | `string` | `""` | no |
| badge\_enabled | Generates a publicly-accessible URL for the projects build badge. Available as badge\_url attribute when enabled | `bool` | `false` | no |
| build\_compute\_type | Instance type of the build instance | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| build\_image | Docker image for build environment, e.g. 'aws/codebuild/standard:2.0' or 'aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0'. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html | `string` | `"aws/codebuild/standard:2.0"` | no |
| build\_timeout | How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed | `number` | `60` | no |
| build\_type | The type of build environment, e.g. 'LINUX\_CONTAINER' or 'WINDOWS\_CONTAINER' | `string` | `"LINUX_CONTAINER"` | no |
| buildspec | Optional buildspec declaration to use for building the project | `string` | `""` | no |
| cache\_bucket\_suffix\_enabled | The cache bucket generates a random 13 character string to generate a unique bucket name. If set to false it uses terraform-null-label's id value. It only works when cache\_type is 'S3 | `bool` | `true` | no |
| cache\_expiration\_days | How many days should the build cache be kept. It only works when cache\_type is 'S3' | `number` | `7` | no |
| cache\_type | The type of storage that will be used for the AWS CodeBuild project cache. Valid values: NO\_CACHE, LOCAL, and S3.  Defaults to NO\_CACHE.  If cache\_type is S3, it will create an S3 bucket for storing codebuild cache inside | `string` | `"NO_CACHE"` | no |
| context | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | <pre>object({<br>    enabled             = bool<br>    namespace           = string<br>    environment         = string<br>    stage               = string<br>    name                = string<br>    delimiter           = string<br>    attributes          = list(string)<br>    tags                = map(string)<br>    additional_tag_map  = map(string)<br>    regex_replace_chars = string<br>    label_order         = list(string)<br>    id_length_limit     = number<br>  })</pre> | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_order": [],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| delimiter | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| encryption\_enabled | When set to 'true' the resource will have AES256 encryption enabled by default | `bool` | `false` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| environment\_variables | A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build | <pre>list(object(<br>    {<br>      name  = string<br>      value = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "NO_ADDITIONAL_BUILD_VARS",<br>    "value": "TRUE"<br>  }<br>]</pre> | no |
| extra\_permissions | List of action strings which will be added to IAM service account permissions. | `list(any)` | `[]` | no |
| fetch\_git\_submodules | If set to true, fetches Git submodules for the AWS CodeBuild build project. | `bool` | `false` | no |
| git\_clone\_depth | Truncate git history to this many commits. | `number` | `null` | no |
| github\_token | (Optional) GitHub auth token environment variable (`GITHUB_TOKEN`) | `string` | `""` | no |
| id\_length\_limit | Limit `id` to this many characters.<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| image\_repo\_name | (Optional) ECR repository name to store the Docker image built by this module. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | `string` | `"UNSET"` | no |
| image\_tag | (Optional) Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | `string` | `"latest"` | no |
| label\_order | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| local\_cache\_modes | Specifies settings that AWS CodeBuild uses to store and reuse build dependencies. Valid values: LOCAL\_SOURCE\_CACHE, LOCAL\_DOCKER\_LAYER\_CACHE, and LOCAL\_CUSTOM\_CACHE | `list(string)` | `[]` | no |
| logs\_config | Configuration for the builds to store log data to CloudWatch or S3. | `any` | `{}` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| private\_repository | Set to true to login into private repository with credentials supplied in source\_credential variable. | `bool` | `false` | no |
| privileged\_mode | (Optional) If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images | `bool` | `false` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| report\_build\_status | Set to true to report the status of a build's start and finish to your source provider. This option is only valid when the source\_type is BITBUCKET or GITHUB | `bool` | `false` | no |
| secondary\_artifact\_encryption\_enabled | Set to true to enable encryption on the secondary artifact bucket | `bool` | `false` | no |
| secondary\_artifact\_identifier | Secondary artifact identifier. Must match the identifier in the build spec | `string` | `null` | no |
| secondary\_artifact\_location | Location of secondary artifact. Must be an S3 reference | `string` | `null` | no |
| source\_credential\_auth\_type | The type of authentication used to connect to a GitHub, GitHub Enterprise, or Bitbucket repository. | `string` | `"PERSONAL_ACCESS_TOKEN"` | no |
| source\_credential\_server\_type | The source provider used for this project. | `string` | `"GITHUB"` | no |
| source\_credential\_token | For GitHub or GitHub Enterprise, this is the personal access token. For Bitbucket, this is the app password. | `string` | `""` | no |
| source\_credential\_user\_name | The Bitbucket username when the authType is BASIC\_AUTH. This parameter is not valid for other types of source providers or connections. | `string` | `""` | no |
| source\_location | The location of the source code from git or s3 | `string` | `""` | no |
| source\_type | The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB\_ENTERPRISE, BITBUCKET or S3 | `string` | `"CODEPIPELINE"` | no |
| source\_version | A version of the build input to be built for this project. If not specified, the latest version is used. | `string` | `""` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |
| versioning\_enabled | A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket | `bool` | `true` | no |
| vpc\_config | Configuration for the builds to run inside a VPC. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| badge\_url | The URL of the build badge when badge\_enabled is enabled |
| cache\_bucket\_arn | Cache S3 bucket ARN |
| cache\_bucket\_name | Cache S3 bucket name |
| project\_arn | Project ARN |
| project\_id | Project ID |
| project\_name | Project name |
| role\_arn | IAM Role ARN |
| role\_id | IAM Role ID |

<!-- markdownlint-restore -->
