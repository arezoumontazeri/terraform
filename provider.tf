terraform {
  backend "s3" {
    bucket         = "s3-terraform-arezou"
    key            = "build/airfllow/terraform.tfstate"
    region         = "eu-north-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
} 