output "application_public_ip" {
  value = aws_instance.application.public_ip
}

# output "database_public_ip" {
#   value = aws_instance.database.public_ip
# }

# output "database_private_ip" {
#   value = aws_instance.database.private_ip
# }