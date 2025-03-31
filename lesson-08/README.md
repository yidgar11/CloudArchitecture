# Terraform HW

This repository contains .... 

Deployment of resources can be triggered upon Github ‘push’ action to the main branch of your github repository.
Or it can configured to be executed manually from the Github Actions console using the flag "workflow_dispatch".

## Table of content
- [Docker ECR Actions Workflow](#docker-ecr-actions-workflow)
  - [Table of content](#table-of-content)
  - [Summary of build steps](#summary-of-build-steps)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [How to Use](#how-to-use)


## Prerequisites
- An active AWS account
- A Github Account
- A Github Repository created
- [OpenID connect configured in AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
- [Terraform v1 or above installed and configured](https://developer.hashicorp.com/terraform/install)
- [An S3 bucket for the Terraform Backend](https://developer.hashicorp.com/terraform/language/settings/backends/s3)
- A DynamoDB table for Terraform State Locking and consistency. The table must have a partition key named LockID with type of String. If not configured, state locking will be disabled.


## Summary of build steps

- Build the image according to the Dockerfile
- Ensure an ECR repository for this GitHub repository exists
- Tag and publish the image to the ECR repository


## Setup
- Dockerfile and any build-related data
- policy.json to dictate the ECR lifecycle policy

## How to Use
The reusable Github Actions workflow template is available under the folder ".github/workflows". As mentioned above the action to trigger the workflow is currently set to "workflow_dispatch", but this can be changed to "push" or "workflow_call" based on your required. for more information check [here](https://docs.github.com/en/actions/using-workflows/triggering-a-workflow)

A sample Dockerfile is added under the directory "e2e-test", this is just for reference and execution of the pipeline.

1. Either edit the ".github/workflows/workflow.yaml" file to update the inputs. This can also be passed via the console when triggering manually.
2. Make sure to pass the right AWS Account ID and region as Inputs.
3. A sample ECR lifecycle policy is added here at "e2e-test/policy.json". Refer next section for more information.
4. Two IAM roles are required as inputs:
  a. An IAM role with permissions to setup the Terraform S3 backend and provided as input `backend_iam_role`
  b. An IAM role with permissions to Github, which is also used in the ECR policy to restrict ECR operations, refer `data.tf` file.

   