resource "aws_instance" "stage" {
  for_each      = var.Staging_Instnace
  ami           = each.value.Ami
  instance_type = each.value.instance_type
  key_name      = each.value.key
  tags = {
    Name = each.key
  }
}
resource "aws_instance" "prod" {
  for_each      = toset(var.product_instance)
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  tags = {
    Name = each.value
  }
}