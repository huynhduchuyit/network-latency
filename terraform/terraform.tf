terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69.0"
    }
  }

  backend "s3" {
    bucket  = "caladan-work-sample"
    key     = "terraform/terraform.tfstate"
    region  = "ap-southeast-1"
    encrypt = true
  }
}
