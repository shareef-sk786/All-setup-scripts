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


# install helm
apt update
apt install -y curl gpg ca-certificates
curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey -o /tmp/helm.gpg

HELM_KEY_ID=$(gpg --show-keys --with-colons /tmp/helm.gpg | awk -F: '$1=="fpr"{print $10; exit}')

if [ "$HELM_KEY_ID" != "DDF78C3E6EBB2D2CC223C95C62BA89D07698DBC6" ]; then
  echo "ERROR: Helm signing key fingerprint does not match"
  exit 1
fi

gpg --dearmor --yes -o /usr/share/keyrings/helm.gpg /tmp/helm.gpg

echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" > /etc/apt/sources.list.d/helm-stable-debian.list

apt update
apt install -y helm
