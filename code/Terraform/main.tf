terraform {
  required_version = "~>1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">5.60"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./vpc"
  env                 = var.env
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  zone                = var.zone
}

module "cloudfront" {
  source = "./cloudfront"
  env    = var.env
}
