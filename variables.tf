variable "aws_profile" {
    description = "AWS access credential profile to use"
}
variable "aws_region" {
    description = "AWS region for your aws resourses"
}

variable "aws_vpc_cidr" {
    description = "CIDR formatted IP"
}

variable "aws_vpc_tags" {
    description = "Tags for newly created vpc"
    default = {}
    type = map(string)
}

variable "aws_vpc_pub_subnet_cidr" {
    description = "Public Subnet CIDR formatted IP"
}

variable "aws_vpc_pri_subnet_cidr" {
    description = "Private Subnet CIDR formatted IP"
}

variable "aws_vpc_public_subnet_tags"{
    description = "Public subnet "
    default = {}
    type = map(string)
}

variable "aws_vpc_private_subnet_tags"{
    description = "Public subnet "
    default = {}
    type = map(string)
}