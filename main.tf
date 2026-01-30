# resource "aws_instance" "stage" {
#   for_each      = var.Staging_Instnace
#   ami           = each.value.Ami
#   instance_type = each.value.instance_type
#   key_name      = each.value.key
#   tags = {
#     Name = each.key
#   }
# }
# resource "aws_instance" "prod" {
#   for_each      = toset(var.product_instance)
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   tags = {
#     Name = each.value
#   }
# }
resource "aws_instance" "infras" {
  for_each      = var.infra_type == "prod" ? var.product_instance : var.Staging_Instnace
  ami           = var.infra_type == "prod" ? each.value.Ami : each.value.Ami
  instance_type = var.infra_type == "prod" ? each.value.instance_type : each.value.instance_type
  key_name      = var.infra_type == "prod" ? each.value.key : each.value.key
  tags = {
    Name = var.infra_type == "prod" ? each.key : each.key
  }
}

