resource "aws_key_pair" "ec2-key" {
  key_name   = "ec2-key"
  public_key = var.key

}


#-----------------------
#  Application Server
#-----------------------
resource "aws_instance" "application" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.ec2-key.key_name

  user_data = file("${path.module}/jenkins.sh")


  # Place EC2 in your VPC public subnet
  subnet_id = var.public_subnet

  # Attach your Security Group
  vpc_security_group_ids = [
    var.sg
  ]

  # Auto-assign Public IP (IMPORTANT)
  associate_public_ip_address = true

  # Root volume configuration
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "${var.ec2_app_name}-jenkins"
  }
}



# # #-----------------------
# # #  Database Server
# # #-----------------------
# resource "aws_instance" "database" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name      = aws_key_pair.ec2-key.key_name

#   # Place EC2 in your VPC Private subnet
#   subnet_id = var.private_subnet

#   # Attach your Security Group
#   vpc_security_group_ids = [
#     var.sg
#   ]

#   # Auto-assign Public IP (IMPORTANT)
#   associate_public_ip_address = false

#   # Root volume configuration
#   root_block_device {
#     volume_size = 8
#     volume_type = "gp3"
#     delete_on_termination = true
#   }

#   tags = {
#     Name = "${var.ec2_app_name}-Database"
#   }
# }
