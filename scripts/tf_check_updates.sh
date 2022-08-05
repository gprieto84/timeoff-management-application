#!/bin/sh
# $1: workspace to check

dir=$(basename "`pwd`")

if [ $dir != "tf" ]
  then
    cd tf
fi

set -e

SAVED_WORKSPACE=$(terraform workspace show)
echo "Your current workspace is $SAVED_WORKSPACE, it will switch if required"

terraform workspace select $1
terraform plan -var-file="envconfig/$1.tfvars"

terraform workspace select $SAVED_WORKSPACE
