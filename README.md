# tf_codebuild

Terraform config to create codebuild project for codepipeline

## Usage

Include this repository as a module in your existing terraform code:

```
module "build" {
    source              = "git::https://github.com/cloudposse/tf_codebuild.git?ref=tags/0.5.0"
    namespace           = "general"
    name                = "ci"
    stage               = "staging"
    
    # http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html
    build_image         = "aws/codebuild/docker:1.12.1"
    instance_size       = "BUILD_GENERAL1_SMALL"
    
    # These attributes are optional, used as ENV variables when building Docker images and pushing them to ECR
    # For more info:
    # http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html
    # https://www.terraform.io/docs/providers/aws/r/codebuild_project.html
    
    privileged_mode     = true
    aws_region          = "us-east-1"
    aws_account_id      = "xxxxxxxxxx"
    image_repo_name     = "ecr-repo-name"
    image_tag           = "latest"
}
```

Grant the required permissions to s3

```
resource "aws_iam_role_policy_attachment" "codebuild_s3" {
  role   = "${module.build.role_arn}"
  policy_arn = "${aws_iam_policy.s3.arn}"
}
```


## Input

| Name            | Default              | Description                                                                                                                                          |
|:---------------:|:--------------------:|:----------------------------------------------------------------------------------------------------------------------------------------------------:|
| namespace       | global               | Namespace                                                                                                                                            |
| stage           | default              | Stage                                                                                                                                                |
| name            | codebuild            | Name                                                                                                                                                 |
| build_image     | (Required)           | Docker image for build environment, _e.g._ `aws/codebuild/docker:1.12.1` or `aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0`                    |
| instance_size   | BUILD_GENERAL1_SMALL | CodeBuild instance size.  Possible values are: ```BUILD_GENERAL1_SMALL``` ```BUILD_GENERAL1_MEDIUM``` ```BUILD_GENERAL1_LARGE```                     |
| buildspec       | ""                   | (Optional) `buildspec` declaration to use for building the project                                                                                   |
| privileged_mode | ""                   | (Optional) If set to true, enables running the Docker daemon inside a Docker container on the `CodeBuild` instance. Used when building Docker images |
| aws_region      | ""                   | (Optional) AWS Region, _e.g._ `us-east-1`. Used as `CodeBuild` ENV variable when building Docker images                                              |
| aws_account_id  | ""                   | (Optional) AWS Account ID. Used as `CodeBuild` ENV variable when building Docker images                                                              |
| image_repo_name | ""                   | (Optional) ECR repository name to store Docker images. Used as `CodeBuild` ENV variable when building Docker images                                  |
| image_tag       | ""                   | (Optional) Docker image tag in the ECR repository, _e.g._ `latest`. Used as `CodeBuild` ENV variable when building Docker images                     |



## Output

| Name         | Decription             |
|:------------:|:----------------------:|
| project_name | CodeBuild project name |
| project_id   | CodeBuild project ARN  |
| role_arn     | IAM Role ARN           |
