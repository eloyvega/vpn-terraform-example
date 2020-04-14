terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = var.region
}