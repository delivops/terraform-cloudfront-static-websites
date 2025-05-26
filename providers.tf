provider "aws" {
  region = var.aws_region
}

# Required for cloudfront certificate to be stored in us-east-1
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

