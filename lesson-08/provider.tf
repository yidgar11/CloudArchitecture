provider "aws" {
  region = "us-east-1" # Set the AWS region to US East (N. Virginia)
}

# Root module (main.tf)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}
