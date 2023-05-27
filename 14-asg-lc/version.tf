terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

}

provider "aws" {
  profile = var.profile
}

# Create Random Pet Resource
resource "random_pet" "this" {
  length = 2
}
