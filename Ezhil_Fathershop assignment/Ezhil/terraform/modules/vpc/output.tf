output "sg_ids" {
  value       = aws_security_group.example[*].id
}

output "subnet_ids" {
  value = values({
    public_ap-south_1a   = aws_subnet.public_ap-south_1a.id
    public_ap-south_1b   = aws_subnet.public_ap-south_1b.id
    private_ap-south_1a  = aws_subnet.private_ap-south_1a.id
    private_ap-south_1b  = aws_subnet.private_ap-south_1b.id
  })
}

output "private_subnet_id" {
  value = aws_subnet.private_ap-south_1a.id
}


