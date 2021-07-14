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

### EC2 Resources ###

#Set Up EC2 Instances

resource "aws_instance" "yellow-blue-instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Team = "Yellow" # "Blue"
  }
}

resource "aws_instance" "red-null-instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  # Empty the value to see "Team" Key alone will not be compliant
  
  tags = {
    Team = "Red" 
  }
}

resource "aws_instance" "green-random-instance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
    
  # Fill in a random key-value pair or just change the value to something random to see anythin else is not compliant
  
  tags = {
    Team = "Green" 
  }
}

# AMI Lookup for EC2 Instance

data "aws_ami" "ubuntu" {
  most_recent = true

  # Filtering for ubuntu because of preference. Can choose another.

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Owner parameter needed and this is the one for the ubuntu one.
  owners = ["099720109477"]
}