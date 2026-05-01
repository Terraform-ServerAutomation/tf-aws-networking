locals {
  name_prefix = "${var.environment}-${var.name}"

  # Use caller-provided AZs or fall back to all available AZs in the region
  azs = length(var.availability_zones) > 0 ? var.availability_zones : data.aws_availability_zones.available.names

  # Number of NAT Gateways to create
  nat_gateway_count = var.enable_nat_gateway && length(var.public_subnet_cidrs) > 0 ? (
    var.single_nat_gateway ? 1 : length(var.public_subnet_cidrs)
  ) : 0

  # Common tags merged with caller-supplied tags
  common_tags = merge(
    {
      Name        = local.name_prefix
      Environment = var.environment
      ManagedBy   = "terraform"
      Module      = "tf-aws-networking"
    },
    var.tags
  )
}
