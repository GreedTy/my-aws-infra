resource "aws_default_vpc" "default" {
  tags = {
    "Name"  = "${var.vpc_prefix}-micro"
  }
}