module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "18.7.2"

  cluster_name                    = var.clusters_name_prefix
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  # IPV6 or IPV4
  cluster_ip_family     = "ipv4"

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  cluster_encryption_config = [{
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }]

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  eks_managed_node_group_defaults = {
  }

  eks_managed_node_groups = {
    default = {
      # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
      # so we need to disable it to use the default template provided by the AWS EKS managed node group service
      create_launch_template  = false
      launch_template_name    = ""

      ami_type                = var.node_groups_ami_type
      platform                = "bottlerocket"

      min_size                = var.node_groups_min_size
      max_size                = var.node_groups_max_size
      desired_size            = var.node_groups_desired_size

      instance_types          = var.node_groups_instance_types

      iam_role_attach_cni_policy = true
    }
  }

  tags = local.common_tags
}

resource "aws_kms_key" "eks" {
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = local.common_tags
}

locals {
  common_tags = {
    ManagedBy   = "terraform"
    ClusterName = var.clusters_name_prefix
  }
}
