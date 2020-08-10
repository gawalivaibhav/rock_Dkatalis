resource "aws_vpc" "main" {
    cidr_block = var.aws_vpc_cidr
    tags = var.aws_vpc_tags
         
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_vpc_pub_subnet_cidr
  tags = var.aws_vpc_public_subnet_tags  
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_vpc_pri_subnet_cidr
  tags = var.aws_vpc_private_subnet_tags
          
}