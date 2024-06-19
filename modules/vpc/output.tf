output "mainvpcid" {
  value = aws_vpc.mainvpc.id
}

output "PublicSubnet1id" {
  value = aws_subnet.PublicSubnet1.id
}

output "dbsubnetgroupname" {
  value = aws_db_subnet_group.db_subnet_group1.name
}