variable "Staging_Instnace" {
  description = "VM definitions"
  type = map(object({
    Ami           = string
    instance_type = string
    key           = string
  }))
}
variable "product_instance" {
  description = "list of VMs name"
  type        = list(string)
}
variable "ami" {}
variable "key_name" {}
variable "instance_type" {}