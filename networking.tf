resource "aws_vpc" "main" {
    cidr_block = var.aws_vpc_cidr
    tags = var.aws_vpc_tags
         
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = var.aws_internet_gatway_tags
}
resource "aws_key_pair" "ec2key" {
  key_name = "publicKey"
  public_key = file(var.public_key_path)
}


