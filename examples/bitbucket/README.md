### Sample Terraform AWS CodeBuild Application for Bitbucket Private Repository ###

This application creates AWS ECR repository and AWS `CodeBuild` project, in specified region `aws_region` for specified profile `àws_profile`. 

Inputs are supplied from `build.auto.tfvars.json` automatically.

#### Install ####
* AWS Client
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html

(Note:Version 1 is also acceptable)

* CW Log Application
**cw** log application should be installed for proper use. (https://github.com/lucagrulla/cw)

Thanks to [lucagrulla](https://github.com/lucagrulla) for this nice logging application. AWS Cli (even in version 2.0) does not support tail to single log stream in a log group where [cw](https://github.com/lucagrulla/cw) does. 

``` 
brew tap lucagrulla/tap
brew install cw
```
#### Configure Your Repository ####
* You need a properly configured and locally tested `Dockerfile`.

named as `Dockerfile` and located in the root folder of your application.
File name: `Dockerfile`
```docker
FROM node:current-slim
WORKDIR /usr/src/app
COPY . .
RUN npm install
EXPOSE 3000
CMD [ "npm", "start"]
```

* Run `docker build . -t sample-app:latest`to test your docker build locally.

* You need to place the following `YAML` file into your application root folder.(Ex: Where package.json is located) (You can find the sample file in example folder)

Sample `builspec.yml`
```yaml
version: 0.2

phases:
  pre_build:
    commands:
      - echo Logging in to Amazon ECR...
      - $(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION)
  build:
    commands:
      - echo Build started on `date`
      - echo Building the Docker image...          
      - docker build -t $IMAGE_REPO_NAME:$IMAGE_TAG .
      - docker tag $IMAGE_REPO_NAME:$IMAGE_TAG $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG      
  post_build:
    commands:
      - echo Build completed on `date`
      - echo Pushing the Docker image...
      - docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG
```


#### RUN ####
```
terraform apply
```

Enter `yes`in command prompt to approve deployment.


After deployment of the environment is complete, a provisioner runs `start-build.sh` script. This script runs the `CodeBuild` project, finds the related `CloudWatch` Log Stream and tails to it, so that logs are viewed in `Terraform` output.

#### Inputs ####

Edit following fields in `build.auto.tfvars.json`
```json
{ 
  "aws_region":"eu-central-1",
  "aws_profile":"default",
  "namespace": "feature",
  "stage":"tests",
  "repository_name":"sample-app",
  "image_tag":"latest",
  "source_credential_user_name":"<ENTER-YOUR-BITBUCKET-USERNAME>",
  "source_credential_token":"<ENTER-YOUR-BITBUCKET-PASSWORD",
  "source_location": "https://bitbucket.org/<YOUR_USER>/<YOUR_REPO>.git",
  "source_version": "<ENTER-YOUR-BRANCH-TO-TEST (Remove line if you work with master)",
  "git_clone_depth": null,
  "extra_permissions": ["EC2:*"],
  "environment_variables":[
    {
      "name":"APP_NAME",
      "value":"my-app"
    },
    {
      "name":"DB_USERNAME",
      "value":"postgres"
    },
    {
      
    }
  ]
}
```

_Where:_

* `source_location` is your private repository URL.
* `source_version` is branch in your repository, which you would like to make a test build. (Remove it, if you want to work with master.)
* `source_credential_user_name` is your `Bitbucket` user name.
* `source_credential_token`is your `Bitbucket` password. (You can create it from here: https://bitbucket.org/account/settings/app-passwords/)
* `extra_permissions` is a list of actions to be appended to IAM permissions
* `git_clone_depth` is used to make a shallow clone for large repositories.
_Note:_

Application name will be created as `namespace-stage-repository_name`. If you omit name space and stage then your application name becomes just `repository_name`

You can omit `aws_profile`as well. In this case `terraform` uses default profile or the one specified in your environment variables (if defined).

_Environment Variables:_

Change the environment variables section with your own environment variables.

#### start-build script parameters ####

```
sh ./start-build.sh --help
```

You may change parameters in null resource local provisioner section.
```terraform
resource "null_resource" "codebuild_provisioner" {
  triggers = {
    value = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = "./start-build.sh ${module.build.project_name} ${var.aws_profile} ${var.aws_region} false 120 60 1 15 6"
    # Arguments
    # <codebuild-project-name> <aws-profile> <aws-region> <print-dots> <initial-timeout> <update-timeout> <sleep-interval> <init-wait-time> <max-retry-count>
  }
```

#### Contributors ####

* Bircan Bilici  
  https://github.com/brcnblc