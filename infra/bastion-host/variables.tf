variable "aws_region" {
    type = string
}

variable "system" {
    type = string
}

variable "env" {
    type = string
}


variable "inbound_cidr_blocks" {
    type = list(string)
    default = [
        "0.0.0.0/0"
    ]
}
