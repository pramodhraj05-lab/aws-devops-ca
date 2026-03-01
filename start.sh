#!/bin/bash

set -e

echo "🚀 Starting full deployment..."

# 1️⃣ Run Terraform
echo "📦 Running Terraform..."
cd terraform
terraform init -input=false
terraform apply -auto-approve

# 2️⃣ Get Elastic IP
echo "🌍 Fetching Elastic IP..."
IP=$(terraform output -raw elastic_ip)

echo "Elastic IP: $IP"

# 3️⃣ Wait for EC2 SSH to be ready
echo "⏳ Waiting for EC2 to become reachable..."
sleep 20

# Optional: actively wait for SSH
until ssh -o StrictHostKeyChecking=no \
          -i ~/aws-keys/docker-key-final.pem \
          ubuntu@$IP "echo SSH Ready" 2>/dev/null
do
  echo "Waiting for SSH..."
  sleep 5
done

echo "✅ EC2 is reachable."

# 4️⃣ Run Ansible
echo "⚙️ Running Ansible..."
cd ../ansible

ansible-playbook -i "$IP," \
  -u ubuntu \
  --private-key ~/aws-keys/docker-key-final.pem \
  install_docker.yml

# 5️⃣ Open website
echo "🌐 Opening website..."
open http://$IP

echo "🎉 Deployment Complete!"
