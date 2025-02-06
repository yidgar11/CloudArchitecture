#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <AWS_ACCOUNT_ID>"
  exit 1
fi

AWS_ID=$1


docker build -t ${AWS_ID}.dkr.ecr.us-east-1.amazonaws.com/cloudarchitecture/l3-webservice-frontend:1.0 .
docker push ${AWS_ID}.dkr.ecr.us-east-1.amazonaws.com/cloudarchitecture/l3-webservice-frontend:1.0