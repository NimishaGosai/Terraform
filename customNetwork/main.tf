# Create VPC

resource "aws_vpc" "dev_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "dev-vpc"
    }
  
  
}

#Create Public Subnet
resource "aws_subnet" "dev_public_subnet" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "dev_public_subnet"
  }
}

#Create Private Subnet
resource "aws_subnet" "dev_private_subnet" {
  vpc_id     = aws_vpc.dev_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "dev_private_subnet"
  }
}

#Create IG
resource "aws_internet_gateway" "dev_IGW" {
  vpc_id = aws_vpc.dev_vpc.id
  tags = {
    Name = "dev_IGW"
  }
}

# Create Route Table
resource "aws_route_table" "dev_public_RT" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_IGW.id
  }
  tags = {
    Name = "dev_public_RT"
  }
}

# Creation of subnet association
resource "aws_route_table_association" "public_subnet_RT_association" {
  subnet_id      = aws_subnet.dev_public_subnet.id
  route_table_id = aws_route_table.dev_public_RT.id
}

# Create Sg Group
resource "aws_security_group" "dev_sg" {
  name        = "dev_sg"
  description = "Allow SSH"
  vpc_id      = aws_vpc.dev_vpc.id

  # Inbound rules
  
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict SSH to your IP
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev_sg"
  }
}

# Create public server in public subnet
resource "aws_instance" "dev_public_server" {
    ami = var.ami-id
    instance_type = var.instance-type
    subnet_id     = aws_subnet.dev_public_subnet.id
      associate_public_ip_address = true

      tags = {
        Name = "public_server"
      }
  
}
