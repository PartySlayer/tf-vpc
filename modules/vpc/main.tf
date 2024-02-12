# crea la vpc
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr 
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.nome_progetto}-vpc"
  }
}

# crea il gateway e lo attacca alla vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "${var.nome_progetto}-igw"
  }
}

# Acquisisce le az nella regione
data "aws_availability_zones" "available_zones" {}

# crea la subnet publica per l' az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.vpc_id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0] # prende la prima (indice 0) az disponibile
  map_public_ip_on_launch = true

  tags      = {
    Name    = "subnet pubblica az1"
  }
}

# crea una subnet publica per l'az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws.vpc.vpc_id
  cidr_block              = var.public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1] # uguale a su ma con la seconda
  map_public_ip_on_launch = true

  tags      = {
    Name    = "subnet pubblica az2"
  }
}

# crea la routing table e aggiunge una route pubblica
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags       = {
    Name     = "rt pubblica"
  }
}

# associa "public subnet az1" a "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.public_route_table.id
}

# associa "public subnet az2" to "public route table"
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id           = aws_subnet.private_app_subnet_az2.id
  route_table_id      = aws_route_table.public_route_table.id
}

# crea una subnet privata per l'app sull'az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_app_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "subnet privata app az1"
  }
}

# crea una subnet privata per l'app sull'az2
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_app_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "subnet privata app az2"
  }
}

# crea una subnet privata per i dati sull'az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_data_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "subnet privata data az1"
  }
}

# crea una subnet privata per i dati sull'az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_data_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "subnet privata data az2"
  }
}
