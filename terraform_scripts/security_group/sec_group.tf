resource "aws_security_group" "my_sec_group" {
  name   = "Rajesh_security_group"
  vpc_id = var.sec_vpc_id

  ingress {
    from_port  = 22
    to_port    = 22
    protocol   = "tcp"
    cidr_blocks = [var.cidr_sec_block]
  }

  ingress {
    from_port  = 80
    to_port    = 80
    protocol   = "tcp"
    cidr_blocks = [var.cidr_sec_block]
  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = [var.cidr_sec_block]
  }
}