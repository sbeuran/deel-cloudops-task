terraform {
  backend "local" {
       path = "tfstate" 
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = {
      ProvisionedBy = "Terraform"
    }
  }
}