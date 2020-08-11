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

variable "aws_internet_gatway_tags"{
    description = "Tags for newly created internet gateway"
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

variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "ap-south-1a"
}

variable "public_key_path" {
  description = "Public key path"
  default = "~/.ssh/id_rsa.pub"
}

variable "instance_ami" {
  description = "AMI for elastic EC2 instances"
  default = "ami-0835240c6a4146612"
}

variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}

variable "open_vpn_ami"{
    description = "This is the AMI for the most recent version of OpenVPN access server with 10 connected devices"
    default = "ami-00b7bb451c0c20931"
}