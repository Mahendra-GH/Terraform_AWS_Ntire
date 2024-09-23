variable "Vpc_info" {
  type = object({
    name                 = string
    cidr_block           = string
    enable_dns_hostnames = bool


    # })
    # default = {
    #   name       = "TerraformVpc",
    #   cidr_block = "172.16.0.0/16"
    # 
  })

}

variable "Subnet_Public" {
  type = list(object({
    name              = string
    subnet_cidr_block = string
    subnet_az         = string
  }))
  #    default = [ {
  #      name = "web-1"
  #      subnet_cidr_block = "172.16.0.0/24"
  #      subnet_az = "ap-south-1a"

  #    } ]
}
variable "Subnet_Private" {
  type = list(object({
    name              = string
    subnet_cidr_block = string
    subnet_az         = string
  }))
  #    default = [ {
  #      name = "app-1"
  #      subnet_cidr_block = "172.16.0.0/24"
  #      subnet_az = "ap-south-1a"

  #    } ]
}

variable "web_security_group" {
  type = object({
    name = string
    ingress = list(object({
      protocol    = string
      port        = number
      source      = string
      description = string
      name        = string

    }))



  })
}
variable "App_security_group" {
  type = object({
    name = string
    ingress = list(object({
      name        = string
      protocol    = string
      port        = number
      description = string
      source      = string
    }))
  })
}
variable "Db_security_group" {
  type = object({
    
    ingress = list(object({
      name        = string
      protocol    = string
      port        = number
      description = string
      source      = string
  }))
  })
  
}