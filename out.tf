output "aws_vpc_id" {
    description = " the ID of "
    value = concat(aws_vpc.main.*.id, [""])[0]
}

output "vpn_access_server_dns" {
    description = "OpenVpn Public IP"
    value = aws_eip.open_vpn_access_server.public_dns
}

output "elastic_instance_ip" {
    description = " the IP of  Elstic instance"
    value = [aws_instance.elastic_Instance.private_ip]
}

