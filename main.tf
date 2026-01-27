
resource "aws_instance" "vm1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = each.value
  }
  for_each = {
    vm1 = "VM_Arezou"
    vm2 = "VM_Hamed"
  }
}