terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
  }

  backend "s3" {
    bucket = "automated-eks-storage-bucket-0702"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }

  required_version = ">= 1.13, < 2.0"

}

# first edit
# modified URL in last step of terraform.yml
# modifeid the URL before script
# checking only stage and main