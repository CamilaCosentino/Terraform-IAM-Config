terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "5.13.1"
        }
    }
}
provider "aws" {
      region     = "us-east-1"
      access_key = "test"
      secret_key = "test"
}
