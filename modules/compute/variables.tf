variable "imageId" {
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type"
  type        = string
  default     = "ami-0233c2d874b811deb"
}



variable "networkInterfaceSG" {
  description = "allows ssh and http from single machine IP"
  type        = string
  default     = "sg-069f2fd59179c74dc"
}


variable "keyName" {
  description = "allows ssh and http from single machine IP"
  type        = string
  default     = "24JULYUSW2.pem"
}