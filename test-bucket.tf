terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use latest version if possible
    }
  }

  backend "s3" {
    bucket  = "s3-jenkins-pipeline1212"                 # Name of the S3 bucket
    key     = "s3-jenkins-pipeline1212.tfstate"        # The name of the state file in the bucket
    region  = "ap-northeast-1"                          # Use a variable for the region
    encrypt = true                                 # Enable server-side encryption (optional but recommended)
  } 
}

provider "aws" {
  region  = "ap-northeast-1"
}

resource "aws_s3_bucket" "frontend" {
  bucket_prefix = "jenkins-bucket-"
  force_destroy = true
  

  tags = {
    Name = "Jenkins Bucket"
  }
}