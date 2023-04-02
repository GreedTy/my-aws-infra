module "bastion" {
  source = "../../module/bastion-host"
  host-name-prefix = local.system_full_name
  vpc_id           = data.aws_vpc.vpc.id
  availability_zone   = "ap-northeast-2c"
  subnet_id           = data.aws_subnets.private.ids[0]
  inbound_cidr_blocks = var.inbound_cidr_blocks
  keypair_name        = "micro-service-${var.env}-key"
  tags = {
    "TerraformManaged" = "true"
  }
  iam_instance_profile = aws_iam_instance_profile.resources-iam-profile.name
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${local.system_full_name}*"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = [
      "${local.system_full_name}-subnet-prv-c"
    ]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["${local.system_full_name}-subnet-pub-c"]
  }
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}


