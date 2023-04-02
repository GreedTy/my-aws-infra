resource "aws_security_group" "bastion" {
  name        = "bastion_from_local"
  description = "Allow SSH connect to bastion instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.inbound_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.host-name-prefix}-sg-bastion-host"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  key_name               = var.keypair_name
  vpc_security_group_ids = [aws_security_group.bastion.id]

  iam_instance_profile = var.iam_instance_profile
  associate_public_ip_address = true
  tags = {
    Name = "${var.host-name-prefix}-bastion-host"
  }
}

resource "aws_eip" "bastion" {
  vpc      = true
  instance = aws_instance.bastion.id
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }
}

