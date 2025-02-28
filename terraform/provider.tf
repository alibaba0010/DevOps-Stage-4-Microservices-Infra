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
  region  = var.aws_region
  # You can also set AWS credentials via environment variables:
   access_key =var.AWS_ACCESS_KEY_ID
  secret_key=var.AWS_SECRET_ACCESS_KEY
}
