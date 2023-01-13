terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

module "storage" {
    source = "./modules/storage"

    website_hosting_bucket_name = var.bucket_name
    website_hosting_bucket_tags = local.info_tags
}
