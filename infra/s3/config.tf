terraform {
  backend "s3" {
    bucket         = "service-infra-terraform-state"
    key            = "service-s3-private-bucket.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "infra-terraform-state-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.3.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = ">= 2.2"
    }
  }
  required_version = "~> 1.4.0"
}

provider "aws" {
  region = var.aws_region
}
