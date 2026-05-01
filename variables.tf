# ============================================================
# General
# ============================================================

variable "name" {
  description = "Name prefix applied to all resources created by this module."
  type        = string
}

variable "environment" {
  description = "Environment identifier (e.g. dev, staging, prod). Used in resource names and tags."
  type        = string
}

variable "tags" {
  description = "A map of additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}

# ============================================================
# VPC
# ============================================================

variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support in the VPC."
  type        = bool
  default     = true
}

# ============================================================
# Subnets
# ============================================================

variable "availability_zones" {
  description = "List of availability zones to use. When empty, the module automatically selects all available AZs in the region."
  type        = list(string)
  default     = []
}

variable "public_subnet_cidrs" {
  description = "List of IPv4 CIDR blocks for public subnets. One subnet is created per entry."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for c in var.public_subnet_cidrs : can(cidrhost(c, 0))])
    error_message = "All public_subnet_cidrs values must be valid IPv4 CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "List of IPv4 CIDR blocks for private subnets. One subnet is created per entry."
  type        = list(string)
  default     = []

  validation {
    condition     = alltrue([for c in var.private_subnet_cidrs : can(cidrhost(c, 0))])
    error_message = "All private_subnet_cidrs values must be valid IPv4 CIDR blocks."
  }
}

# ============================================================
# NAT Gateway
# ============================================================

variable "enable_nat_gateway" {
  description = "Whether to provision NAT Gateways to allow private subnets to reach the internet."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway shared by all private subnets (reduces cost; not recommended for production)."
  type        = bool
  default     = false
}

# ============================================================
# VPC Flow Logs
# ============================================================

variable "enable_flow_logs" {
  description = "Whether to enable VPC Flow Logs to CloudWatch Logs."
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "Number of days to retain VPC Flow Logs in the CloudWatch Log Group."
  type        = number
  default     = 30

  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.flow_logs_retention_days)
    error_message = "flow_logs_retention_days must be a valid CloudWatch Logs retention period value."
  }
}
