#!/bin/bash

# usage:
# $ apply_updates.sh env region
# Defaults to test environment in all regions

dir=$(basename "`pwd`")

if [ $dir != "tf" ]
  then
    cd tf
fi

env=$1
region='us-east-1'
if [ $# -gt 0 ]
  then
    env=$1
fi

SAVED_WORKSPACE=$(terraform workspace show)

for e in $env
    do
      echo "Destroying resources for $e in region $region"
      terraform workspace select $e
      terraform destroy -var "env=$e" -var "region=$region" -var-file="envconfig/$e.tfvars" -auto-approve
    done

terraform workspace select $SAVED_WORKSPACE