resource "aws_route_table" "route_table" {
  for_each = var.route_tables
  vpc_id   = aws_vpc.main.id
  tags = {
    Name = each.key
  }
}
resource "aws_route" "route_internet" {
  for_each               = var.route_tables
  route_table_id         = aws_route_table.route_table[each.key].id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = var.route_tables[each.key].is_public ? "0.0.0.0/0" : null

}
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.sub["private_subnet"].id
  route_table_id = aws_route_table.route_table["private"].id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.sub["public_subnet"].id
  route_table_id = aws_route_table.route_table["public"].id
}






