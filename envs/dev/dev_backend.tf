terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.30.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

# terraform {
#   backend "s3" {
#     bucket         = "ajay-terraform-state-041124309752"
#     region         = "us-east-1"
#     key            = "terraform/terraform.tfstate"
#     use_lockfile = true
#   }
# }

