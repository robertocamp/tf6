variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "imageId" {
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type"
  type        = string
  default     = "ami-0dc8f589abe99f538"
}


variable "instanceType" {
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type"
  type        = string
  default     = "t2.micro"
}


variable "networkInterfaceSG" {
  description = "allows ssh and http from single machine IP"
  type        = list(string)
  default     = ["sg-069f2fd59179c74dc"]
}


variable "keyName" {
  description = "allows ssh and http from single machine IP"
  type        = string
  default     = "24JULYUSW2"
}
