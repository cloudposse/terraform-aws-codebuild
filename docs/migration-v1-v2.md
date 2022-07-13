## Migration Notes for Dynamic Subnets v2.0

### &nbsp; Breaking change: S3 cache bucket

The S3 bucket resource was replaced with an *(S3 module)[https://github.com/cloudposse/terraform-aws-s3-bucket]*.
* Do not upgrade if using Terraform older than 1.0.
* Do not upgrade if you are using AWS provider older than 4.22.

There are no changes in input and output variables.

### &nbsp; Upgrade instructions
The upgrade is two faceted. 
1. Update terraform to a version equal to or newer than version 1.0. You can follow the **[Upgrading to Terraform v1.0](https://www.terraform.io/language/upgrade-guides/1-0)** guide.
2. Update the AWS provider to the latest version. You can follow the S3 bucket modules **[Upgrading to v2.0](https://github.com/cloudposse/terraform-aws-s3-bucket/wiki/Upgrading-to-v2.0)** guide.