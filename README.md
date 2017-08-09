# tf_codebuild

Terraform config to create codebuild project for codepipeline

## Usage

Include this repository as a module in your existing terraform code:

```
module "build" {
  source    = "git::https://github.com/cloudposse/tf_codebuild.git"
  namespace = "general"
  name      = "ci"
  stage     = "staging"

  image         = "apline"
  instance_size = "BUILD_GENERAL1_SMALL"
}
```

Grant appropriate permsissions to s3

```
resource "aws_iam_role_policy_attachment" "codebuild_s3" {
  role   = "${module.build.role_arn}"
  policy_arn = "${aws_iam_policy.s3.arn}"
}
```

## Input

|      Name     |        Default       |                                                    Decription                                                    |
|:-------------:|:--------------------:|:----------------------------------------------------------------------------------------------------------------:|
|   namespace   |        global        |                                                     Namespace                                                    |
|     stage     |        default       |                                                      Stage                                                       |
|      name     |       codebuild      |                                                       Name                                                       |
|     image     |        alpine        |                                         Docker image used as environment                                         |
| instance_size | BUILD_GENERAL1_SMALL |  Instance size for job.  Possible values are: ```BUILD_GENERAL1_SMALL``` ```BUILD_GENERAL1_MEDIUM``` ```BUILD_GENERAL1_LARGE```|

## Output

|     Name     |       Decription       |
|:------------:|:----------------------:|
| project_name | CodeBuild project name |
|  project_id  |  CodeBuild project arn |
|   role_arn   |      IAM Role arn      |
