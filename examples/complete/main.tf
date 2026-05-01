module "networking" {
  source = "../.."

  name        = var.name
  environment = var.environment

  vpc_cidr = "10.0.0.0/16"

  availability_zones   = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false

  enable_flow_logs         = true
  flow_logs_retention_days = 30

  tags = {
    Project   = "example"
    CreatedBy = "terraform"
  }
}
