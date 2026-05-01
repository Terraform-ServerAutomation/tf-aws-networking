# ============================================================
# VPC
# ============================================================

output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "The ARN of the VPC."
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "The primary IPv4 CIDR block of the VPC."
  value       = aws_vpc.this.cidr_block
}

# ============================================================
# Subnets
# ============================================================

output "public_subnet_ids" {
  description = "List of IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "List of CIDR blocks of the public subnets."
  value       = aws_subnet.public[*].cidr_block
}

output "private_subnet_ids" {
  description = "List of IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "private_subnet_cidrs" {
  description = "List of CIDR blocks of the private subnets."
  value       = aws_subnet.private[*].cidr_block
}

output "availability_zones" {
  description = "List of availability zones in which subnets were created."
  value       = local.azs
}

# ============================================================
# Internet Gateway
# ============================================================

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway. Empty string when no public subnets are defined."
  value       = length(aws_internet_gateway.this) > 0 ? aws_internet_gateway.this[0].id : ""
}

# ============================================================
# NAT Gateway
# ============================================================

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs."
  value       = aws_nat_gateway.this[*].id
}

output "nat_gateway_public_ips" {
  description = "List of public Elastic IP addresses associated with the NAT Gateways."
  value       = aws_eip.nat[*].public_ip
}

# ============================================================
# Route Tables
# ============================================================

output "public_route_table_id" {
  description = "ID of the public route table. Empty string when no public subnets are defined."
  value       = length(aws_route_table.public) > 0 ? aws_route_table.public[0].id : ""
}

output "private_route_table_ids" {
  description = "List of IDs of the private route tables."
  value       = aws_route_table.private[*].id
}

# ============================================================
# Flow Logs
# ============================================================

output "flow_log_id" {
  description = "The ID of the VPC Flow Log. Empty string when flow logs are disabled."
  value       = length(aws_flow_log.this) > 0 ? aws_flow_log.this[0].id : ""
}

output "flow_log_cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch Log Group used for VPC Flow Logs."
  value       = length(aws_cloudwatch_log_group.flow_logs) > 0 ? aws_cloudwatch_log_group.flow_logs[0].arn : ""
}
