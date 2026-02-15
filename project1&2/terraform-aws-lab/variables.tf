variable "aws_region" {
  default = "eu-north-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}
variable "subnets" {
  type = map(object({
    cidr_block              = string
    map_public_ip_on_launch = bool
  }))

}

variable "route_tables" {
  type = map(object({
    is_public = bool
  }))
}







