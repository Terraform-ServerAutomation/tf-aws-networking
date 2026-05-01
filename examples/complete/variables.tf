variable "aws_region" {
  description = "AWS region to deploy resources into."
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Name prefix for all resources."
  type        = string
  default     = "networking"
}

variable "environment" {
  description = "Environment identifier."
  type        = string
  default     = "dev"
}
