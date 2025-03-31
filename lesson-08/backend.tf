terraform {
  backend "s3" {
    bucket         = "yidgar-tf-state-bucket"
    key            = "prod/terraform.tfstate"  # Path inside the bucket
    region         = "us-east-1"
    encrypt        = true                      # Encrypt the state file
    dynamodb_table = "terraform-locking"       # For state locking
  }
}