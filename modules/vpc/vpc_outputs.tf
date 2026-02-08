output "vpc_name" {value = aws_vpc.vpc.tags["Name"]}

output "vpc_id" {value = aws_vpc.vpc.id}

output "igw" {value = aws_internet_gateway.igw.id}

output "public_id" { value = aws_subnet.public.id}

output "private_id" {value = aws_subnet.private.id}

output "sg_id" {value = aws_security_group.sg.id}
