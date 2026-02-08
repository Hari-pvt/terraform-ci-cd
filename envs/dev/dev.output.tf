output "vpc_public_ip" {
  value = module.vpc.public_id
}

output "application_public_ip" {
    value = module.ec2.application_public_ip
}

# output "database_public_ip" {
#     value = module.ec2.database_public_ip
# }

# output "database_private_ip" {
#     value = module.ec2.database_private_ip
# }