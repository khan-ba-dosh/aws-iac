variable "instances" {
    description = "Map of instances to create"
    type = map(object({
      instance_type = string
      ami           = string
      key_name      = string
      #script        = string
    }))

}


 variable "volumes" {
    description = "Map of volumes to create"
    type = map(object({
      size = number
      az   = string
    }))


  }

variable "attachments" {
    description = "Map of volumes to create"
    type = map(object({
      device_name = string
      vm_name = string
      vol_name = string
    }))
 }

variable "subnet_id"{

}
