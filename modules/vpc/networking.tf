resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"

  tags = {
    Name = "subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "igw"
  }
} 
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route = []

  tags = {
    Name = "example"
  }
}

resource "aws_route" "route" {
  route_table_id            = aws_route_table.rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id
  depends_on                = [aws_route_table.rt]
}

resource "aws_security_group" "sg" {
  name        = "allow all traffic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "all traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1" 
    cidr_blocks      = [aws_vpc.myvpc.cidr_block]
    ipv6_cidr_blocks = null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "Outbound Rules"
    prefix_list_ids = null
    security_groups = null
    self = null
    }

  tags = {
    Name = "all traffic"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}

output "vpc_id"{
    value = "${aws_vpc.myvpc.id}"
}

output "subnet_id"{
    value = "${aws_subnet.main.id}"
}
