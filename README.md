<!-- markdownlint-disable -->
# terraform-aws-codebuild [![Latest Release](https://img.shields.io/github/release/cloudposse/terraform-aws-codebuild.svg)](https://github.com/cloudposse/terraform-aws-codebuild/releases) [![Slack Community](https://slack.cloudposse.com/badge.svg)](https://slack.cloudposse.com)
<!-- markdownlint-restore -->

[![README Header][readme_header_img]][readme_header_link]

[![Cloud Posse][logo]](https://cpco.io/homepage)

<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->

Terraform module to create AWS CodeBuild project for AWS CodePipeline.


---

This project is part of our comprehensive ["SweetOps"](https://cpco.io/sweetops) approach towards DevOps.
[<img align="right" title="Share via Email" src="https://docs.cloudposse.com/images/ionicons/ios-email-outline-2.0.1-16x16-999999.svg"/>][share_email]
[<img align="right" title="Share on Google+" src="https://docs.cloudposse.com/images/ionicons/social-googleplus-outline-2.0.1-16x16-999999.svg" />][share_googleplus]
[<img align="right" title="Share on Facebook" src="https://docs.cloudposse.com/images/ionicons/social-facebook-outline-2.0.1-16x16-999999.svg" />][share_facebook]
[<img align="right" title="Share on Reddit" src="https://docs.cloudposse.com/images/ionicons/social-reddit-outline-2.0.1-16x16-999999.svg" />][share_reddit]
[<img align="right" title="Share on LinkedIn" src="https://docs.cloudposse.com/images/ionicons/social-linkedin-outline-2.0.1-16x16-999999.svg" />][share_linkedin]
[<img align="right" title="Share on Twitter" src="https://docs.cloudposse.com/images/ionicons/social-twitter-outline-2.0.1-16x16-999999.svg" />][share_twitter]


[![Terraform Open Source Modules](https://docs.cloudposse.com/images/terraform-open-source-modules.svg)][terraform_modules]



It's 100% Open Source and licensed under the [APACHE2](LICENSE).







We literally have [*hundreds of terraform modules*][terraform_modules] that are Open Source and well-maintained. Check them out!







## Security & Compliance [<img src="https://cloudposse.com/wp-content/uploads/2020/11/bridgecrew.svg" width="250" align="right" />](https://bridgecrew.io/)

Security scanning is graciously provided by Bridgecrew. Bridgecrew is the leading fully hosted, cloud-native solution providing continuous Terraform security and compliance.

| Benchmark | Description |
|--------|---------------|
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![CIS KUBERNETES](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/cis_kubernetes)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=CIS+KUBERNETES+V1.5) | Center for Internet Security, KUBERNETES Compliance |
| [![CIS AWS](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=CIS+AWS+V1.2) | Center for Internet Security, AWS Compliance |
| [![CIS AZURE](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/cis_azure)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=CIS+AZURE+V1.1) | Center for Internet Security, AZURE Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![CIS GCP](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=CIS+GCP+V1.1) | Center for Internet Security, GCP Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/cloudposse/terraform-aws-codebuild/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=cloudposse%2Fterraform-aws-codebuild&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |



## Usage


**IMPORTANT:** We do not pin modules to versions in our examples because of the
difficulty of keeping the versions in the documentation in sync with the latest released versions.
We highly recommend that in your code you pin the version to the exact version you are
using so that your infrastructure remains stable, and update versions in a
systematic way so that they do not catch you by surprise.

Also, because of a bug in the Terraform registry ([hashicorp/terraform#21417](https://github.com/hashicorp/terraform/issues/21417)),
the registry shows many of our inputs as required when in fact they are optional.
The table below correctly indicates which inputs are required.


Include this module in your existing terraform code:

```hcl
module "build" {
    source = "cloudposse/codebuild/aws"
    # Cloud Posse recommends pinning every module to a specific version
    # version     = "x.x.x"
    namespace           = "eg"
    stage               = "staging"
    name                = "app"

    # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    build_image         = "aws/codebuild/standard:2.0"
    build_compute_type  = "BUILD_GENERAL1_SMALL"
    build_timeout       = 60

    # These attributes are optional, used as ENV variables when building Docker images and pushing them to ECR
    # For more info:
    # http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html
    # https://www.terraform.io/docs/providers/aws/r/codebuild_project.html

    privileged_mode     = true
    aws_region          = "us-east-1"
    aws_account_id      = "xxxxxxxxxx"
    image_repo_name     = "ecr-repo-name"
    image_tag           = "latest"

    # Optional extra environment variables
    environment_variables = [{
        name  = "JENKINS_URL"
        value = "https://jenkins.example.com"
      },
      {
        name  = "COMPANY_NAME"
        value = "Amazon"
      },
      {
        name = "TIME_ZONE"
        value = "Pacific/Auckland"

      }]
}
```






<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform code

```
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| aws | >= 2.0 |
| random | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.0 |
| random | >= 2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this | cloudposse/label/null | 0.24.1 |

## Resources

| Name |
|------|
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_codebuild_project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) |
| [aws_codebuild_source_credential](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_source_credential) |
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) |
| [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) |

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
| context | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| delimiter | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| encryption\_enabled | When set to 'true' the resource will have AES256 encryption enabled by default | `bool` | `false` | no |
| environment | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| environment\_variables | A list of maps, that contain both the key 'name' and the key 'value' to be used as additional environment variables for the build | <pre>list(object(<br>    {<br>      name  = string<br>      value = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "NO_ADDITIONAL_BUILD_VARS",<br>    "value": "TRUE"<br>  }<br>]</pre> | no |
| extra\_permissions | List of action strings which will be added to IAM service account permissions. | `list(any)` | `[]` | no |
| fetch\_git\_submodules | If set to true, fetches Git submodules for the AWS CodeBuild build project. | `bool` | `false` | no |
| git\_clone\_depth | Truncate git history to this many commits. | `number` | `null` | no |
| github\_token | (Optional) GitHub auth token environment variable (`GITHUB_TOKEN`) | `string` | `""` | no |
| id\_length\_limit | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| image\_repo\_name | (Optional) ECR repository name to store the Docker image built by this module. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | `string` | `"UNSET"` | no |
| image\_tag | (Optional) Docker image tag in the ECR repository, e.g. 'latest'. Used as CodeBuild ENV variable when building Docker images. For more info: http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html | `string` | `"latest"` | no |
| label\_key\_case | The letter case of label keys (`tag` names) (i.e. `name`, `namespace`, `environment`, `stage`, `attributes`) to use in `tags`.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| label\_order | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| label\_value\_case | The letter case of output label values (also used in `tags` and `id`).<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Default value: `lower`. | `string` | `null` | no |
| local\_cache\_modes | Specifies settings that AWS CodeBuild uses to store and reuse build dependencies. Valid values: LOCAL\_SOURCE\_CACHE, LOCAL\_DOCKER\_LAYER\_CACHE, and LOCAL\_CUSTOM\_CACHE | `list(string)` | `[]` | no |
| logs\_config | Configuration for the builds to store log data to CloudWatch or S3. | `any` | `{}` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| private\_repository | Set to true to login into private repository with credentials supplied in source\_credential variable. | `bool` | `false` | no |
| privileged\_mode | (Optional) If set to true, enables running the Docker daemon inside a Docker container on the CodeBuild instance. Used when building Docker images | `bool` | `false` | no |
| regex\_replace\_chars | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| report\_build\_status | Set to true to report the status of a build's start and finish to your source provider. This option is only valid when the source\_type is BITBUCKET or GITHUB | `bool` | `false` | no |
| secondary\_sources | (Optional) secondary source for the codebuild project next to the primary location defined in variable source\_location | <pre>list(object(<br>    {<br>      git_clone_depth     = number<br>      location            = string<br>      source_identifier   = string<br>      type                = string<br>      fetch_submodules    = bool<br>      insecure_ssl        = bool<br>      report_build_status = bool<br>  }))</pre> | `[]` | no |
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



## Share the Love

Like this project? Please give it a ★ on [our GitHub](https://github.com/cloudposse/terraform-aws-codebuild)! (it helps us **a lot**)

Are you using this project or any of our other projects? Consider [leaving a testimonial][testimonial]. =)


## Related Projects

Check out these related projects.

- [terraform-aws-ecs-codepipeline](https://github.com/cloudposse/terraform-aws-ecs-codepipeline) - Terraform Module for CI/CD with AWS Code Pipeline and Code Build for ECS



## Help

**Got a question?** We got answers.

File a GitHub [issue](https://github.com/cloudposse/terraform-aws-codebuild/issues), send us an [email][email] or join our [Slack Community][slack].

[![README Commercial Support][readme_commercial_support_img]][readme_commercial_support_link]

## DevOps Accelerator for Startups


We are a [**DevOps Accelerator**][commercial_support]. We'll help you build your cloud infrastructure from the ground up so you can own it. Then we'll show you how to operate it and stick around for as long as you need us.

[![Learn More](https://img.shields.io/badge/learn%20more-success.svg?style=for-the-badge)][commercial_support]

Work directly with our team of DevOps experts via email, slack, and video conferencing.

We deliver 10x the value for a fraction of the cost of a full-time engineer. Our track record is not even funny. If you want things done right and you need it done FAST, then we're your best bet.

- **Reference Architecture.** You'll get everything you need from the ground up built using 100% infrastructure as code.
- **Release Engineering.** You'll have end-to-end CI/CD with unlimited staging environments.
- **Site Reliability Engineering.** You'll have total visibility into your apps and microservices.
- **Security Baseline.** You'll have built-in governance with accountability and audit logs for all changes.
- **GitOps.** You'll be able to operate your infrastructure via Pull Requests.
- **Training.** You'll receive hands-on training so your team can operate what we build.
- **Questions.** You'll have a direct line of communication between our teams via a Shared Slack channel.
- **Troubleshooting.** You'll get help to triage when things aren't working.
- **Code Reviews.** You'll receive constructive feedback on Pull Requests.
- **Bug Fixes.** We'll rapidly work with you to fix any bugs in our projects.

## Slack Community

Join our [Open Source Community][slack] on Slack. It's **FREE** for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally *sweet* infrastructure.

## Discourse Forums

Participate in our [Discourse Forums][discourse]. Here you'll find answers to commonly asked questions. Most questions will be related to the enormous number of projects we support on our GitHub. Come here to collaborate on answers, find solutions, and get ideas about the products and services we value. It only takes a minute to get started! Just sign in with SSO using your GitHub account.

## Newsletter

Sign up for [our newsletter][newsletter] that covers everything on our technology radar.  Receive updates on what we're up to on GitHub as well as awesome new projects we discover.

## Office Hours

[Join us every Wednesday via Zoom][office_hours] for our weekly "Lunch & Learn" sessions. It's **FREE** for everyone!

[![zoom](https://img.cloudposse.com/fit-in/200x200/https://cloudposse.com/wp-content/uploads/2019/08/Powered-by-Zoom.png")][office_hours]

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-codebuild/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or [help out](https://cpco.io/help-out) with our other projects, we would love to hear from you! Shoot us an [email][email].

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!


## Copyright

Copyright © 2017-2021 [Cloud Posse, LLC](https://cpco.io/copyright)



## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```









## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

This project is maintained and funded by [Cloud Posse, LLC][website]. Like it? Please let us know by [leaving a testimonial][testimonial]!

[![Cloud Posse][logo]][website]

We're a [DevOps Professional Services][hire] company based in Los Angeles, CA. We ❤️  [Open Source Software][we_love_open_source].

We offer [paid support][commercial_support] on all of our projects.

Check out [our other projects][github], [follow us on twitter][twitter], [apply for a job][jobs], or [hire us][hire] to help with your cloud strategy and implementation.



### Contributors

<!-- markdownlint-disable -->
|  [![Erik Osterman][osterman_avatar]][osterman_homepage]<br/>[Erik Osterman][osterman_homepage] | [![Igor Rodionov][goruha_avatar]][goruha_homepage]<br/>[Igor Rodionov][goruha_homepage] | [![Andriy Knysh][aknysh_avatar]][aknysh_homepage]<br/>[Andriy Knysh][aknysh_homepage] | [![Jamie Nelson][Jamie-BitfFlight_avatar]][Jamie-BitfFlight_homepage]<br/>[Jamie Nelson][Jamie-BitfFlight_homepage] | [![Sarkis Varozian][sarkis_avatar]][sarkis_homepage]<br/>[Sarkis Varozian][sarkis_homepage] | [![Bircan Bilici][brcnblc_avatar]][brcnblc_homepage]<br/>[Bircan Bilici][brcnblc_homepage] |
|---|---|---|---|---|---|
<!-- markdownlint-restore -->

  [osterman_homepage]: https://github.com/osterman
  [osterman_avatar]: https://img.cloudposse.com/150x150/https://github.com/osterman.png
  [goruha_homepage]: https://github.com/goruha
  [goruha_avatar]: https://img.cloudposse.com/150x150/https://github.com/goruha.png
  [aknysh_homepage]: https://github.com/aknysh
  [aknysh_avatar]: https://img.cloudposse.com/150x150/https://github.com/aknysh.png
  [Jamie-BitfFlight_homepage]: https://github.com/Jamie-BitfFlight
  [Jamie-BitfFlight_avatar]: https://img.cloudposse.com/150x150/https://github.com/Jamie-BitfFlight.png
  [sarkis_homepage]: https://github.com/sarkis
  [sarkis_avatar]: https://img.cloudposse.com/150x150/https://github.com/sarkis.png
  [brcnblc_homepage]: https://github.com/brcnblc
  [brcnblc_avatar]: https://img.cloudposse.com/150x150/https://github.com/brcnblc.png

[![README Footer][readme_footer_img]][readme_footer_link]
[![Beacon][beacon]][website]

  [logo]: https://cloudposse.com/logo-300x69.svg
  [docs]: https://cpco.io/docs?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=docs
  [website]: https://cpco.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=website
  [github]: https://cpco.io/github?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=github
  [jobs]: https://cpco.io/jobs?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=jobs
  [hire]: https://cpco.io/hire?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=hire
  [slack]: https://cpco.io/slack?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=slack
  [linkedin]: https://cpco.io/linkedin?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=linkedin
  [twitter]: https://cpco.io/twitter?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=twitter
  [testimonial]: https://cpco.io/leave-testimonial?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=testimonial
  [office_hours]: https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=office_hours
  [newsletter]: https://cpco.io/newsletter?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=newsletter
  [discourse]: https://ask.sweetops.com/?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=discourse
  [email]: https://cpco.io/email?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=email
  [commercial_support]: https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=commercial_support
  [we_love_open_source]: https://cpco.io/we-love-open-source?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=we_love_open_source
  [terraform_modules]: https://cpco.io/terraform-modules?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=terraform_modules
  [readme_header_img]: https://cloudposse.com/readme/header/img
  [readme_header_link]: https://cloudposse.com/readme/header/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=readme_header_link
  [readme_footer_img]: https://cloudposse.com/readme/footer/img
  [readme_footer_link]: https://cloudposse.com/readme/footer/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=readme_footer_link
  [readme_commercial_support_img]: https://cloudposse.com/readme/commercial-support/img
  [readme_commercial_support_link]: https://cloudposse.com/readme/commercial-support/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-aws-codebuild&utm_content=readme_commercial_support_link
  [share_twitter]: https://twitter.com/intent/tweet/?text=terraform-aws-codebuild&url=https://github.com/cloudposse/terraform-aws-codebuild
  [share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-aws-codebuild&url=https://github.com/cloudposse/terraform-aws-codebuild
  [share_reddit]: https://reddit.com/submit/?url=https://github.com/cloudposse/terraform-aws-codebuild
  [share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/cloudposse/terraform-aws-codebuild
  [share_googleplus]: https://plus.google.com/share?url=https://github.com/cloudposse/terraform-aws-codebuild
  [share_email]: mailto:?subject=terraform-aws-codebuild&body=https://github.com/cloudposse/terraform-aws-codebuild
  [beacon]: https://ga-beacon.cloudposse.com/UA-76589703-4/cloudposse/terraform-aws-codebuild?pixel&cs=github&cm=readme&an=terraform-aws-codebuild
