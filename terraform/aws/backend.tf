terraform {
  backend "s3" {
    bucket = "sciitdevops-backend"
    key    = "infra/aws.tfstate"
    region = "eu-west-1"
  }
}