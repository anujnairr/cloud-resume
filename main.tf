
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

resource "terraform_data" "exec" {

  provisioner "local-exec" {

    interpreter = ["bash", "-c"]
    on_failure  = continue
    command     = <<-EOF
    aws s3 cp src s3://${module.cloudfront.s3}/ --recursive 2>&1 /dev/null
    EOF
  }
}

module "oidc" {
  source = "./oidc"
  env    = var.env
  s3-arn = module.cloudfront.s3-arn
}

module "dynamodb" {
  source = "./dynamodb"
  env    = var.env
}


module "lambda" {
  source        = "./lambda"
  env           = var.env
  region        = var.region
  dynamodb-arn  = module.dynamodb.arn
  dynamodb-name = module.dynamodb.name
  depends_on    = [module.dynamodb]
}

module "apigw" {
  source            = "./apigw"
  env               = var.env
  lambda-invoke-urn = module.lambda.lambda-arn
  function-name     = module.lambda.function-name
}
