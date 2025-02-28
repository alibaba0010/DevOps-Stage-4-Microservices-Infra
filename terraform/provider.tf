terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  
}

provider "aws" {
  region  = var.aws_region //us-east-1 
  # You can also set AWS credentials via environment variables:
  # export AWS_ACCESS_KEY_ID=...
  # export AWS_SECRET_ACCESS_KEY=...
}
