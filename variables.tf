variable "Staging_Instnace" {
  description = "VM definitions"
  type = map(object({
    Ami           = string
    instance_type = string
    key           = string
  }))
}