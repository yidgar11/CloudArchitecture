# here we define the S3 bucket with the dynamodb table to save the tfstate file 
terraform {
  backend "s3" {
    bucket         = "yidgar-terraform-state-bucket-user100"
    key            = "prod/terraform.tfstate"  # Path inside the bucket
    region         = "us-east-1"
    encrypt        = true                      # Encrypt the state file
    dynamodb_table = "terraform-locking-user100"       # For state locking
  }
}