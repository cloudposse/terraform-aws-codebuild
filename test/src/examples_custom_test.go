package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/custom using Terratest.
func TestExamplesCustom(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/custom",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	projectName := terraform.Output(t, terraformOptions, "project_name")

	expectedProjectName := "eg-test-codebuild-custom-policy"
	// Verify we're getting back the outputs we expect
	assert.Equal(t, expectedProjectName, projectName)

	// Run `terraform output` to get the value of an output variable
	cacheS3BucketName := terraform.Output(t, terraformOptions, "cache_bucket_name")

	expectedCacheS3BucketName := "eg-test-codebuild-custom-policy"
	// Verify we're getting back the outputs we expect
	assert.Contains(t, cacheS3BucketName, expectedCacheS3BucketName, "Bucket should contain prefix")
}
