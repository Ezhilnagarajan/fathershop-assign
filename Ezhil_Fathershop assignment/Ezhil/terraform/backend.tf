terraform {
  backend "s3" {
    bucket  = "demo-bucket-php-website"
    key     = "eks/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}