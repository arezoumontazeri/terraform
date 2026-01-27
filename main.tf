resource "aws_instance" "stage" {
  for_each      = var.Staging_Instnace
  ami           = each.value.Ami
  instance_type = each.value.instance_type
  key_name      = each.value.key
  tags = {
    Name = each.key
  }
}