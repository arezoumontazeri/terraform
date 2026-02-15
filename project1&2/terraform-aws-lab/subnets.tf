#resource "aws_subnet" "public" {
#  vpc_id                  = aws_vpc.main.id
#  cidr_block              = var.public_subnet_cidr
#  map_public_ip_on_launch = true

#  tags = {
# #    Name = "public-subnet"
#   }
# }

# resource "aws_subnet" "private" {
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.private_subnet_cidr
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "private-subnet"
#   }
# }
resource "aws_subnet" "sub" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = "${each.key}-subnet"
  }
}
