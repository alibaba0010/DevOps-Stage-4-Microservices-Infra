# TODO Microservices App Infrastructure Setup

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Setup Instructions](#setup-instructions)
- [Infrastructure Details](#infrastructure-details)
- [Deployment Process](#deployment-process)
- [Environment Variables and Configuration](#environment-variables-and-configuration)

---

## Overview

This repository contains Terraform and Ansible scripts for deploying the TODO Microservices application on AWS using an EC2 instance. The infrastructure includes:

- An EC2 instance with a security group allowing necessary traffic
- Automated provisioning using Terraform and Ansible
- Docker and Docker Compose setup for containerized deployment
- SSL certificate configuration using DuckDNS

## Requirements

Before proceeding, ensure you have the following installed and configured:

### Tools:

- **AWS CLI** (configured with an IAM user having necessary permissions for Terraform)
- **Terraform** (latest version recommended)
- **Ansible** (latest version recommended)
- **SSH Key Pair** (preconfigured in AWS for SSH access)

### Folder Structure

```
infrastructure/
├── README.md
|
|-─ main.tf
│── outputs.tf
│── variables.tf
│── provider.tf
├── ansible
│ ├── inventory.ini (or dynamic inventory script)
│ ├── roles
│ │ └── docker_install
│ │ ├── tasks
│ │ │ └── main.yml
│ └── site.yml
└── deploy.sh
```

## Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/alibaba0010/DevOps-Stage-4-Microservices-Infra.git
   cd DevOps-Stage-4-Microservices-Infra
   ```

2. **Create a Terraform Variables File (`terraform.tfvars`)**
   Create a file named `terraform.tfvars` and populate it with the necessary values:

   ```hcl
   aws_region = "your-aws-region"
   ami_id = "your-ami-id"
   instance_type = "your-instance-type"
   key_name = "your-key-pair-name"
   security_group_name = "your-security-group-name"
   cidr_blocks = ["your-allowed-cidr-blocks"]
   ssh_key_path = "path-to-your-private-ssh-key"
   ```

3. **Initialize and Apply Terraform**

   ```bash
   terraform init
   terraform apply -auto-approve
   ```

   - This will provision the EC2 instance and security group.
   - The Ansible inventory file will be automatically created.

4. **Run Ansible Playbook for Server Configuration**
   ```bash
   ansible-playbook -i ansible/inventory ansible/site.yml
   ```
   - This will install Docker, set up networking, and deploy the TODO application.

## Infrastructure Details

### Terraform Resources:

- **EC2 Instance:** The application server where the TODO app will be deployed.
- **Security Group:** Configured with rules for SSH (22), HTTP (80), and HTTPS (443).
- **Provisioners:**
  - `local-exec` to generate the Ansible inventory file.
  - `null_resource` to wait for SSH access before configuration.

### Security Group Rules:

| Protocol | Port | Description      |
| -------- | ---- | ---------------- |
| TCP      | 22   | SSH access       |
| TCP      | 80   | HTTP access      |
| TCP      | 443  | HTTPS access     |
| ALL      | ALL  | Outbound traffic |

## Deployment Process

1. **Clone Application Repository**
   - The Ansible playbook pulls the latest version of the TODO app.
2. **Setup SSL Certificates**
   - DuckDNS is used to configure SSL using Let's Encrypt.
3. **Deploy Application using Docker Compose**
   - The application runs inside a Docker container with necessary dependencies.

## Environment Variables and Configuration

### Terraform Variables:

| Variable              | Description                           |
| --------------------- | ------------------------------------- |
| `aws_region`          | AWS region for deployment             |
| `ami_id`              | AMI ID for the EC2 instance           |
| `instance_type`       | Type of EC2 instance (e.g., t2.micro) |
| `key_name`            | AWS key pair name for SSH access      |
| `security_group_name` | Name of the security group            |
| `cidr_blocks`         | List of allowed IP ranges             |
| `ssh_key_path`        | Path to the SSH private key           |

### Ansible Playbook Configuration:

- Installs Docker and Docker Compose
- Clones the TODO app repository
- Runs Docker Compose to deploy services

## Notes

- Ensure your IAM user has permissions for EC2, VPC, and security groups.
- The EC2 instance will be accessible via the generated public IP from Terraform output.
- Docker containers will be orchestrated within a custom network.
- SSL certificates are configured via DuckDNS API.

## Output

After deployment, Terraform will output the EC2 instance's public IP:

```bash
terraform output instance_ip
```

To access the endpoints of the todo app:

- **Login:** https://adedibu.duckdns.org
- **Auth API:** https://adedibu.duckdns.org/api/auth
- **Todos API:** https://adedibu.duckdns.org/api/todos
- **User API:** https://adedibu.duckdns.org/api/users

---

This setup provides an automated, reproducible deployment process for the TODO application using Terraform and Ansible on AWS.
