terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
    alias = "ap"
  region = "ap-south-1"
}

provider "aws" {
    alias = "us"
  region = "us-east-1"
}

