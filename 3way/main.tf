# specifichiamo il provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# configuriamo il provider
provider "aws" {
    region = var.regione
    profile = "terraform"
  
}

# creiamo una vpc grazie al modulo
module "vpc" {
  source                          = "../modules/vpc"
  regione                         = var.regione
  nome_progetto                   = var.nome_progetto
  vpc_cidr                        = var.vpc_cidr
  public_subnet_az1_cidr          = var.public_subnet_az1_cidr
  public_subnet_az2_cidr          = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr     = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr     = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr    = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr    = var.private_data_subnet_az2_cidr
}