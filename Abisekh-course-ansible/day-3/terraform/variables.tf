
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}


# File uploads handled by CI/CD pipeline

variable "tags" {

  type        = map(string)
  default = {
    Project     = "ansible-learn"
    Environment = "portfolio"
  }
}

variable "day_no" {
  type = string
  default = "03"
}