#!/bin/bash

#install kubectl 
sudo apt update -y
sudo apt install -y curl unzip tar gzip
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
rm -f kubectl

# -----------------------------
# Install eksctl
# -----------------------------

ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz"

tar -xzf "eksctl_${PLATFORM}.tar.gz" -C /tmp

sudo install -m 0755 /tmp/eksctl /usr/local/bin/eksctl

# Verify eksctl
eksctl version

# Remove temporary files
rm -f "eksctl_${PLATFORM}.tar.gz"
rm -f /tmp/eksctl

echo "kubectl and eksctl installation completed successfully."
