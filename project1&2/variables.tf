variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}
variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS key pair name"
  type        = string
  default     = "keyvpc"
}
