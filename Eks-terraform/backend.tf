terraform {
  backend "s3" {
    bucket = "sibapanda-s3bucket" # Replace with your actual S3 bucket name
    key    = "Jenkins-terraform-eks.tfstate"
    region = "ap-south-1"
  }
}
