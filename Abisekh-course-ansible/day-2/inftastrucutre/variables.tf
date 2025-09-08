
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "environment" {
  description = "Environment (local or ci)"
  type        = string
  default     = "local"
}


# File uploads handled by CI/CD pipeline

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Project     = "ansible-learn"
    Environment = "portfolio"
  }
}
