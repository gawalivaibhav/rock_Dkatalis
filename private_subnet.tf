resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = "false"
  cidr_block = var.aws_vpc_pri_subnet_cidr
  availability_zone = var.availability_zone
  tags = var.aws_vpc_private_subnet_tags          
}


# allow internet access for private subnet instances through nat instance #1
resource "aws_route_table" "rtb_private" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        instance_id = aws_instance.nat.id
    }
    tags = {
        Name = "route_table_dekatalis"
    }
}

resource "aws_route_table_association" "private_subnet_to_nat_instance" {
  route_table_id = aws_route_table.rtb_private.id
  subnet_id      = aws_subnet.private.id
}


resource "aws_security_group" "sg" {
  name = "dkatalist_elastic_sg"
  vpc_id = aws_vpc.main.id  
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  
  ingress {
      from_port   = 9300
      to_port     = 9300
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
      from_port   = 9200
      to_port     = 9200
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      Name = "dkatalist_elastic_sg"
 }  
}


resource "aws_instance" "elastic_Instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [ aws_security_group.sg.id]
  key_name = aws_key_pair.ec2key.key_name
  tags = {
      Name = "Elastic_instance"
 }
}