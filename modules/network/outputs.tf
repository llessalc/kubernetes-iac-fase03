output "subnet_priv-a_id" {
  value = aws_subnet.private-a.id
}

output "subnet_priv-b_id" {
  value = aws_subnet.private-b.id
}

output "subnet_pub-a_id" {
  value = aws_subnet.public-a.id
}

output "subnet_pub-b_id" {
  value = aws_subnet.public-b.id
}
