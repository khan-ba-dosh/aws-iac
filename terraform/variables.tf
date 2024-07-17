variable "aws_region" {
    description = "The AWS region to deploy resources"
    type        = string
    default     = "ap-south-1"#"us-east-1"
  }

  variable "ak" {
    default     = "AWS_AK"
  }

  variable "sk" {
    default     = "AWS_SK"
  }

  variable "instances" {
    description = "Map of instances to create"
    type = map(object({
      instance_type = string
      ami           = string
      key_name      = string
      #script        = string
    }))
    default = {
      lin_vm = {
        instance_type = "t2.micro"
        ami           = "ami-0ad21ae1d0696ad58"
        key_name      = "my-key"
        #script        = script.sh
      }
      win_vm = {
        instance_type = "t2.micro"
        ami           = "ami-09f6da726716a4ca6"
        key_name      = "my-key"
        #script        = script.ps1
      }
    }
  }

  variable "volumes" {
    description = "Map of volumes to create"
    type = map(object({
      size = number
      az   = string
    }))
    default = {
      lin_vol = {
        size = 20
        az   = "us-east-1"
      }
      win_vol = {
         size = 20
         az   = "us-east-1"
      }
    }
  }

  variable "attachments" {
    description = "Map of volumes to create"
    type = map(object({
      device_name = string
      vm_name = string
      vol_name = string
    }))
    default = {
      att_lin = {
        device_name = "/dev/sdp"
        vm_name = "lin_vm"
        vol_name = "lin_vol"
      }
      att_win = {
         device_name = "xvdf"
         vm_name = "win_vm"
         vol_name = "win_vol"
      }
    }
  }
