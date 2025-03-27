terraform {
  backend "s3" {
    bucket = "sciitdevops-backend"
    key    = "infra/azure.tfstate"
    region = "eu-west-1"
  }
}