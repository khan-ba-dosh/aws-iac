provider "aws" {
    region = var.aws_region

    access_key = var.ak
    secret_key = var.sk
  }

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
  }


  resource "aws_subnet" "main" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = var.aws_region
  }




  module "vm" {

   source = "../modules/vm"
   subnet_id = aws_subnet.main.id
   volumes = var.volumes
   attachments = var.attachments
   instances  = var.instances
  }
