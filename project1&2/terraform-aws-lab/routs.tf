resource "aws_route_table" "route_table" {
  for_each = var.route_tables
  vpc_id   = aws_vpc.main.id
  tags = {
    Name = each.key
  }
}
resource "aws_route" "route_internet" {
  #for_each               = var.route_tables
  for_each = {
    for k, v in var.route_tables : k => v
    if v.is_public
  }

  route_table_id         = aws_route_table.route_table[each.key].id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
    #route_table_id         = aws_route_table.route_table[each.key].id
  #gateway_id             = aws_internet_gateway.igw.id
  #destination_cidr_block = var.route_tables[each.key].is_public ? "0.0.0.0/0" : null
}

resource "aws_route_table_association" "assoc" {
  for_each = var.subnets

  subnet_id      = aws_subnet.sub[each.key].id
  route_table_id = aws_route_table.route_table[each.key].id
}

#resource "aws_route_table_association" "private_assoc" {
#  subnet_id      = aws_subnet.sub["private"].id
#  route_table_id = aws_route_table.route_table["private"].id
#}

#resource "aws_route_table_association" "public_assoc" {
#  subnet_id      = aws_subnet.sub["public"].id
#  route_table_id = aws_route_table.route_table["public"].id
#}






