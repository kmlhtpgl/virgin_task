#!/bin/bash

set -e

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: $0 <env>"
  exit 1
fi

terraform workspace select $ENV || terraform workspace new $ENV
terraform apply -var-file="envs/$ENV/terraform.tfvars" -auto-approve
