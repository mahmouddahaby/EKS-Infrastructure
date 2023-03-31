#!/bin/bash

# Install AWS cli
sudo apt update -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install

#Install kubectl 
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# move cred connect to the cluster
mkdir /home/ubuntu/.aws


## Connect to the cluster
aws eks --region "us-east-1" update-kubeconfig --name Fixeds-eks

# Apply yaml files for jenkins 
kubectl apply -f k8s/.

# Create name space for jenkins and jenkins agent
kubectl create namespace devops-tools

# Install helm to apply nginx proxy

# Add the official Helm GPG key
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Helm
sudo apt-get update && sudo apt-get install helm

# Add ingress nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx  

# Install ingress nginx
helm install ingress-nginx


