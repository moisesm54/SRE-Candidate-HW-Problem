##Terraform Main File
# Set up to be adapted for Terraform Cloud

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "remote" {
    organization = "[REPLACE WITH ORG]"

    workspaces {
      name = "[REPLACE WITH WORKSPACE]"
    }
  }
}