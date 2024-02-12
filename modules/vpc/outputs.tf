output "regione" {
  value = var.regione
}

output "nome progetto" {
  value = var.nome_progetto
}

output "vpc id" {
  value = aws_vpc.vpc.id
}

output "id subnet pubblica az1" {
  value = aws_subnet.public_subnet_az1.id
}

output "id subnet pubblica az2" {
  value = aws_subnet.public_subnet_az2.id
}

output "id subnet privata app az1" {
  value = aws_subnet.private_app_subnet_az1.id
}

output "id subnet privata app az2" {
  value = aws_subnet.private_app_subnet_az2.id
}

output "id subnet privata dati az1" {
  value = aws_subnet.private_data_subnet_az1.id
}

output "id subnet privata dati az2" {
  value = aws_subnet.private_data_subnet_az2.id
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}