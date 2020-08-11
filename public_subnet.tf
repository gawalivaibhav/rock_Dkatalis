resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_vpc_pub_subnet_cidr
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone
  tags = var.aws_vpc_public_subnet_tags
  depends_on = [aws_internet_gateway.igw]  
}


resource "aws_route_table" "rtb_public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "route_table_dekatalis"
    }
}

resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rtb_public.id
}


### Set up OpenVpn for secure VPN access for elastic

resource "aws_security_group" "vpn_access_server"{
    name = "OpenVpn_Sg"
    description = "Security group for VPN access server"
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "OpenVpn_Sg"
    }

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 943
    to_port   = 943
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "udp"
    from_port = 1194
    to_port   = 1194
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "vpn_access_server" {
  ami                         = var.open_vpn_ami
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.vpn_access_server.id]
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  key_name                    = aws_key_pair.ec2key.key_name

  tags = {
    Name = "Open-vpn-access-server"
  }
}

resource "aws_eip" "open_vpn_access_server" {
  instance = aws_instance.vpn_access_server.id
  vpc = true
}


#Nat instance Security Group

resource "aws_security_group" "access_via_nat" {
    name = "Access_to_nat_instance_Sg"
    description = "Access to internet via nat instance for private nodes"
    vpc_id = aws_vpc.main.id
    tags  = {
        Name = "Access_to_nat_instance_Sg"
    }
    ingress {
        protocol  = "tcp"
        from_port = 0
        to_port   = 65535
        cidr_blocks = ["10.0.2.0/24"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    

}


#Nat instance
resource "aws_instance" "nat" {
  ami                         = "ami-00b3aa8a93dd09c13"
  instance_type               = "t2.micro"
  source_dest_check           = false
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.access_via_nat.id]

  tags = {
    Name = "NAT instance"
  }
}