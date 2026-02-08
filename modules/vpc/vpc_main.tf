#---------------------
#   VPC Creation
#---------------------
resource "aws_vpc" "vpc" {
    cidr_block  =   var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags ={
        Name = var.vpc_name
    }
}

#-------------------
#   Internet Gateway
#-------------------
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.vpc_name}_igw"
    }
}

#------------------
#  Public Subnet
#------------------
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.a_z
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.vpc_name}-public-subnet"
    }
}

#------------------
#  Private Subnet
#------------------
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.a_z

    tags ={
        Name = "${var.vpc_name}-private-subnet"
    }
}

#---------------------
#  Public Route table
#---------------------
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id
    
    route {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {Name = "${var.vpc_name}-public-rt"}
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}


#---------------------
#  Private Route table
#---------------------

# this code create the new route table for private
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.vpc-flash.id

#   tags = {
#     Name = "flash-private-rt"
#   }
# }

# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.private.id
#   route_table_id = aws_route_table.private.id
# }


# this code give the tags to exating route when vpc create that    
resource "aws_default_route_table" "private" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_default_route_table.private.id
}


# -------------------
# Security Group
# -------------------
resource "aws_security_group" "sg" {
    name = "${var.vpc_name}-sg"
    description = "Allow SSH and HTTP"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    ingress {
        description = "jenkins"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }






    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.vpc_name}-sg"
    }
}