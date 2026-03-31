terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use latest version if possible
    }
  }

  backend "s3" {
    bucket  = "s3-jenkins-pipeline1212"                 # Name of the S3 bucket
    key     = "s3-jenkins-pipeline1212.tfstate"         # The name of the state file in the bucket
    region  = "ap-northeast-1"                          # Use a variable for the region
    encrypt = true                                      # Enable server-side encryption (optional but recommended)
  } 
}

provider "aws" {
  region  = "ap-northeast-1"
}

locals {
  G-CheckEvidence = {
    "armageddon.txt"                    = "text/plain"
    "Webhook.png"                       = "image/png"
    "PipelineApply.png"                 ="image/png"
   }
}

resource "aws_s3_object" "submission_evidence" {
  for_each = local.G-CheckEvidence

  bucket       = aws_s3_bucket.frontend.id
  key          = each.key
  source       = "${path.module}/G-CheckEvidence/${each.key}"
  content_type = each.value
  source_hash  = filemd5("${path.module}/G-CheckEvidence/${each.key}")
}

resource "aws_s3_bucket" "frontend" {
  bucket_prefix = "jenkins-bucket-"
  force_destroy = true
  

  tags = {
    Name = "Jenkins Bucket"
  }
}


