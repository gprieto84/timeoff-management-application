#!/bin/sh

dir=$(basename "`pwd`")

if [ $dir != "tf" ]
  then
    cd tf
fi

set -e

echo "Setting terraform project"
terraform init --backend-config="envconfig/backend.tfvars"

echo "Attempting to create terraform workspaces..."
terraform workspace new dev
terraform workspace new prod

echo "Done"