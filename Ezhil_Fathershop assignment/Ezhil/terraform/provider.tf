provider "aws" {
  region = "ap-south-1"
}

# provider "acme" {
#   server_url = "https://acme-v02.api.letsencrypt.org/directory"
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.46"
    }
  }
}