output "aws_vpc_id" {
    description = " the ID of "
    value = concat(aws_vpc.main.*.id, [""])[0]
}