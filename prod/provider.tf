terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  cloud {
    organization = "adilk_terraform"

    workspaces {
      name = "production_environment"
    }
  }
}