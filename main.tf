# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "my-test-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-east-1a", "eu-east-1b", "eu-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_sg" {
  name        = "${var.name}-SG"    
  description = "Allow tls inbound traffic"

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cidr_blocks #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  }

  egress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]  #tfsec:ignore:aws-ec2-no-public-egress-sgr
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name}-SG"
  }
}

resource "aws_instance" "web" {
   
  ami                    = "ami-0573ef119dcb77219"
  instance_type          = "t2.micrro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_sg.id]
  iam_instance_profile   = "demoprofile"
  
  metadata_options {
    
  }
}