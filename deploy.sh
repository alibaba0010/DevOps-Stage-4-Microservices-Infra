#!/usr/bin/env bash

# Exit on error
set -e

# 1. Terraform init & apply
cd terraform
terraform init
terraform apply -auto-approve

# 2. Grab the public IP from Terraform outputs
PUBLIC_IP=$(terraform output -raw public_ip)
cd ..

# 3. Update Ansible inventory (static approach)
#   Here we simply replace a placeholder in inventory.ini with the actual IP
sed -i "s/<PUBLIC_IP_OR_DNS>/$PUBLIC_IP/" ansible/inventory.ini

# 4. Run Ansible
cd ansible
ansible-playbook -i inventory.ini site.yml
