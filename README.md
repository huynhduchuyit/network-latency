# 🖥️ Network Latency Monitoring Project

## Overview

This project provisions two EC2 instances in AWS and deploys an application on one of them that measures and exposes the network latency to the second server.

The infrastructure is defined as code using Terraform. The application is automatically installed and configured on EC2 instances by using a custom AMI built with Packer, combined with shell script user data.

## 📂 Repository Structure
```
app (Application source code)
├── docker-compose.yml: Docker Compose config
├── Dockerfile: Docker image build
├── main.py: Python application code
├── requirements.txt: Python dependencies
└── results.txt: Output application

packer (Packer to build custom AMIs)
├── scripts
│   └── install-docker.sh: Bash script to install Docker
├── templates
│   └── .envrc: environment variables config (for direnv)
│   └── plugins.pkr.hcl: Packer config for plugins
│   └── ubuntu-24-04-lts.pkr.hcl: Packer config to build Ubuntu 24.04 LTS image
│   └── variables.pkr.hcl: Packer variables definitions

terraform (Terraform to provision AWS infrastructure)
├── modules
│   ├── ec2
│   │   └── main.tf: EC2 module Terraform config
│   │   └── outputs.tf: EC2 module outputs definitions
│   │   └── variables.tf: EC2 module input variables
│   ├── ssh
│   │   └── main.tf: SSH module Terraform config
│   │   └── outputs.tf: SSH module outputs definitions
│   │   └── variables.tf: SSH module input variables
├── .envrc: environment variables config (for direnv)
├── ec2.tf: Terraform config for EC2 resources
├── providers.tf: Terraform providers setup (e.g., AWS)
├── security-group.tf: Terraform config for security groups
├── setup.sh: Bash script for EC2 user_data
├── terraform.tf: Terraform configuration file
└── variables.tf: global Terraform input variables
```

## 🚀 How to Provision and Deploy Application

### 1. Build the Custom AMI with Packer

Create or update the .envrc file with the following environment variables to provide AWS credentials:
```
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
```

Use the following commands to initialize and build the AMI using Packer:
```
cd packer/templates
packer init .
packer build .
```

### 2. Deploy Infrastructure with Terraform

Create or update the .envrc file with the following environment variables to provide AWS credentials:
```
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
export TF_VAR_ami_id_first_server="your-ami-id" (AMI will be built by Packer)
```

Use the following commands to provision AWS infrastructure using Terraform:
```
cd terraform
terraform init
terraform apply
```

Terraform will create:
- Server 1 (Network Latency App)
- Server 2 (Ping target)
- Security groups for ICMP & HTTP access

## 📊 How to access the latency metrics

Call the endpoint to get the network latency on the first server:
```
curl http://<public_ip_first_server>:5000/latency
```

Example response for the network latency endpoint on the first server:
```
[2025-08-12 06:56:53] Latency: 0.27 ms
```

Call the endpoint to list the network latency results on the first server:
```
curl http://<public_ip_first_server>:5000/latency-results
```

Example response for the network latency results endpoint on the first server:
```
[2025-08-12 06:57:53] Latency: 0.28 ms
[2025-08-12 06:58:53] Latency: 0.25 ms
...
```

## 🛠️ Technology Used

- **Python & Flask:** Develop the latency measurement app and expose it via an HTTP API. Flask is lightweight and well-suited for building simple APIs.
- **ping3:** A lightweight Python library for sending ICMP ping requests to measure network latency.
- **Docker:** Containerize the latency measurement application to ensure isolated deployments.
- **Terraform:** Automate infrastructure provisioning and management using Infrastructure as Code to create and maintain cloud resources.
- **Packer:** Automate the creation of machine images with pre-installed software for consistent and repeatable server environments.
- **direnv:** Manage environment variables securely and conveniently across environments.

## ⚠️ Assumptions, Limitations, and Tradeoffs

- Both servers are in the same VPC/subnet for minimal network latency.
- ICMP (ping) traffic is allowed between the first server and the second server.
- The app measures latency to a single fixed target only.
- The `/latency` and `/latency-results` endpoints are accessible without authentication.