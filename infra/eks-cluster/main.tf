module "eks_cluster" {
  source = "../../modules/cluster-eks"
  aws_region = var.aws_region
  clusters_name_prefix = local.system_full_name
  cluster_version = "1.24"
  vpc_id = data.aws_vpc.vpc.id
  public_subnet_ids = data.aws_subnets.public.ids
  private_subnet_ids = data.aws_subnets.private.ids
  cluster_endpoint_public_access_cidrs = null
  node_groups_ami_type = "BOTTLEROCKET_x86_64"
  node_groups_min_size = 4
  node_groups_max_size = 4
  node_groups_desired_size = 4
  node_groups_instance_types = [""]
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${local.system_full_name}*"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = [
      "${local.system_full_name}-subnet-pub"
    ]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = [
      "${local.system_full_name}-subnet-prv"
    ]
  }
}
