# tf-aws-networking

Terraform module for provisioning a production-ready AWS networking foundation, including VPC, public/private subnets, Internet Gateway, NAT Gateways, route tables, and VPC Flow Logs.

---

## Features

- VPC with configurable CIDR block, DNS hostnames, and DNS support
- Public subnets with an Internet Gateway and a shared route table
- Private subnets with per-AZ (or single shared) NAT Gateways
- Separate route tables per private subnet for granular traffic control
- Default Security Group locked down (no ingress/egress) following CIS benchmarks
- Default NACL managed explicitly to prevent Terraform drift
- VPC Flow Logs to CloudWatch Logs with configurable retention
- Least-privilege IAM role scoped to the specific Log Group ARN
- Input validation on CIDR blocks and log retention values
- Consistent resource tagging via `common_tags` merge

---

## Usage

```hcl
module "networking" {
  source = "github.com/Terraform-ServerAutomation/tf-aws-networking"

  name        = "myapp"
  environment = "prod"

  vpc_cidr = "10.0.0.0/16"

  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false  # true for non-prod to reduce cost

  enable_flow_logs         = true
  flow_logs_retention_days = 30

  tags = {
    Project = "myapp"
    Owner   = "platform-team"
  }
}
```

See [examples/complete](./examples/complete) for a full working example.

---

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| aws | >= 5.0 |

---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name prefix applied to all resources | `string` | — | yes |
| `environment` | Environment identifier (e.g. dev, prod) | `string` | — | yes |
| `vpc_cidr` | IPv4 CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| `availability_zones` | AZs to use (auto-detected when empty) | `list(string)` | `[]` | no |
| `public_subnet_cidrs` | CIDR blocks for public subnets | `list(string)` | `[]` | no |
| `private_subnet_cidrs` | CIDR blocks for private subnets | `list(string)` | `[]` | no |
| `enable_dns_hostnames` | Enable DNS hostnames in the VPC | `bool` | `true` | no |
| `enable_dns_support` | Enable DNS support in the VPC | `bool` | `true` | no |
| `enable_nat_gateway` | Provision NAT Gateways for private subnets | `bool` | `true` | no |
| `single_nat_gateway` | Use one NAT Gateway for all private subnets | `bool` | `false` | no |
| `enable_flow_logs` | Enable VPC Flow Logs to CloudWatch | `bool` | `true` | no |
| `flow_logs_retention_days` | Retention period (days) for flow log group | `number` | `30` | no |
| `tags` | Additional tags to apply to all resources | `map(string)` | `{}` | no |

---

## Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | ID of the VPC |
| `vpc_arn` | ARN of the VPC |
| `vpc_cidr_block` | Primary CIDR block of the VPC |
| `public_subnet_ids` | IDs of public subnets |
| `public_subnet_cidrs` | CIDR blocks of public subnets |
| `private_subnet_ids` | IDs of private subnets |
| `private_subnet_cidrs` | CIDR blocks of private subnets |
| `availability_zones` | Availability zones used |
| `internet_gateway_id` | ID of the Internet Gateway |
| `nat_gateway_ids` | IDs of NAT Gateways |
| `nat_gateway_public_ips` | Public EIPs of NAT Gateways |
| `public_route_table_id` | ID of the public route table |
| `private_route_table_ids` | IDs of private route tables |
| `flow_log_id` | ID of the VPC Flow Log |
| `flow_log_cloudwatch_log_group_arn` | ARN of the Flow Logs CloudWatch Log Group |

---

## Contributing

1. Fork the repository and create a feature branch from `dev`.
2. Run `terraform fmt -recursive` before committing.
3. Ensure `terraform validate` passes.
4. Open a pull request against `main` using the provided PR template.

---

## License

[MIT](./LICENSE)