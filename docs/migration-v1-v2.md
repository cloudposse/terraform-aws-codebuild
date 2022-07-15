## Migration Notes for CodeBuild v2.0

### Breaking change: S3 cache bucket

The S3 bucket resource was replaced with an *(S3 module)[https://github.com/cloudposse/terraform-aws-s3-bucket]*. 
This module now requires Terraform version 1.0 or later and AWS Terraform provider version 4.9 or later.

There are no changes in input and output variables.

### Upgrade instructions
The upgrade is two faceted. 
1. Update terraform to a version equal to or newer than version 1.0. You can follow the **[Upgrading to Terraform v1.0](https://www.terraform.io/language/upgrade-guides/1-0)** guide.
2. Update the AWS provider to the latest version. You can follow the S3 bucket modules **[Upgrading to v2.0](https://github.com/cloudposse/terraform-aws-s3-bucket/wiki/Upgrading-to-v2.0)** guide.