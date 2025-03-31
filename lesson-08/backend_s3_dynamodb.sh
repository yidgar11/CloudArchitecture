#!/bin/bash

echo "Create S3 bucket 'yidgar-terraform-state-bucket' using aws-cli"
aws s3api list-buckets | grep yidgar-tf-state-bucket 2>/dev/null && echo ">> Bucket already exists" || aws s3api create-bucket --bucket yidgar-tf-state-bucket --region us-east-1

echo
echo "Create the dynamodb table 'terraform-locking' for the lock file"
aws dynamodb describe-table --table-name terraform-locking | grep terraform-locking 2>/dev/null && echo ">> Table already exists" || aws dynamodb create-table --table-name terraform-locking --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
