terraform {
  required_version = "1.2.3"

  backend "s3" {
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.39.0"
    }
  }
}

provider "aws" {
  region = var.region
}
