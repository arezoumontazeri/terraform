resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-route-table"
  }
}
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-route-table"
  }
}
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_security_group" "main_sg" {
  name        = "main-security-group"
  description = "Allow ICMP, HTTP, HTTPS, SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # not safe for production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-sg"
  }
}
resource "aws_network_acl" "main_nacl" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-nacl"
  }
}
resource "aws_network_acl_rule" "inbound_ssh" {
  network_acl_id = aws_network_acl.main_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "inbound_http" {
  network_acl_id = aws_network_acl.main_nacl.id
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "inbound_https" {
  network_acl_id = aws_network_acl.main_nacl.id
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "inbound_icmp" {
  network_acl_id = aws_network_acl.main_nacl.id
  rule_number    = 130
  egress         = false
  protocol       = "icmp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = -1
  icmp_code      = -1
}
resource "aws_network_acl_rule" "outbound_all" {
  network_acl_id = aws_network_acl.main_nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}
resource "aws_network_acl_association" "public_nacl_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  network_acl_id = aws_network_acl.main_nacl.id
}
resource "aws_instance" "db1" {
  ami                    = "ami-0683ee28af6610487"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  key_name               = "keyvpc"

  tags = {
    Name = "db1"
  }
}

resource "aws_instance" "db2" {
  ami                    = "ami-0683ee28af6610487"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  key_name               = "keyvpc"

  tags = {
    Name = "db2"
  }
}
resource "aws_instance" "web" {
  ami                    = "ami-0683ee28af6610487"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  key_name               = "keyvpc"

  tags = {
    Name = "web"
  }
}