#!/bin/sh

# Exit if anything fails
set -e

# Create a timestamp for uniquefying stuff
timestamp=`date +"%Y%m%d%H%M%S"`

# Install terraform
mkdir terraform
cd terraform
wget https://releases.hashicorp.com/terraform/0.9.1/terraform_0.9.1_linux_amd64.zip
unzip terraform_0.9.1_linux_amd64.zip
cd ..
