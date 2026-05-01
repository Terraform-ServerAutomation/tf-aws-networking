output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.networking.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = module.networking.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.networking.private_subnet_ids
}

output "nat_gateway_public_ips" {
  description = "Public IPs of the NAT Gateways."
  value       = module.networking.nat_gateway_public_ips
}
