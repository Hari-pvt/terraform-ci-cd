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


resource "aws_s3_bucket" "tf_state" {
  bucket = "ajay-terraform-state-041124309752"

  tags = {
    Name        = "terraform-state"
    Environment = "shared"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
