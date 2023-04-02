variable "aws_region" {
  type = string
}

variable "clusters_name_prefix" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "cluster_endpoint_public_access_cidrs" {
  type = list(string)
}

variable "node_groups_ami_type" {
  type = string
}

variable "node_groups_min_size" {
  type = number
}

variable "node_groups_max_size" {
  type = number
}

variable "node_groups_desired_size" {
  type = number
}

variable "node_groups_instance_types" {
  type = list(string)
}
