terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.5"
    }
  }

  required_version = "~> 1.5"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      TerraformSource = "infra"
    }
  }
}
