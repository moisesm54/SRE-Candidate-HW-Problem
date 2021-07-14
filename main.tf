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

### SNS Resources ###

#Setup AWS SNS Topics

resource "aws_sns_topic" "alert-topic" {
  name = "noncompliance_alert"
}

resource "aws_sns_topic" "slo-topic" {
  name = "slo_meet_alert"
}

#AWS SNS Topic Subscriptions

resource "aws_sns_topic_subscription" "subscribe-noncompliance" {
  topic_arn = aws_sns_topic.alert-topic.arn
  protocol  = "email"
  #Intended to send to people working with EC2 Instances
  endpoint  = "[REPLACE WITH GROUP E-MAIL]"
}

resource "aws_sns_topic_subscription" "subscribe-slo" {
  topic_arn = aws_sns_topic.slo-topic.arn
  protocol  = "email"
  #Intended to send to devops e-mail as requested for AC
  endpoint  = "devops@uship.com"
}

### IAM Resources ###

#Setup AWS IAM Role

resource "aws_iam_role" "config-role" {
  name = "ConfigServiceRole"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        #Mutable Principals. This was the only one that worked on my deployment.
        #Aware of the vulnerabilities being public.
        "Principal": {
            "AWS": "*"
          },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  })
}

#Setup AWS IAM Role Policy
resource "aws_iam_role_policy" "config-policy" {
  name = "ConfigPolicy"
  role = aws_iam_role.aws-config-role.id

  policy = jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "config:Put*",
          "Effect": "Allow",
          "Resource": "*"
        }
      ]
    })
}