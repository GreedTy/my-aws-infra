variable "host-name-prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "availability_zone" {
  type = string
}
variable "inbound_cidr_blocks" {
  type = list(string)
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map
}

variable "keypair_name" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}

variable "instance_type" {
  default = "t2.medium"
}