# Use the AWS Base Infrastructure Module
module "base_infrastructure" {
  source       = "../../terraform-modules/aws-base-infrastructure"
  day_number   = var.day_no
  project_name = "day-${var.day_no}-${var.tags.Project}"

  instance_count = 2
  instance_type  = "t2.micro"
  spot_max_price = "0.005"

  ssh_key_path        = "../../ssh/ansible-key.pub"
  allowed_cidr_blocks = ["0.0.0.0/0"]

  additional_security_group_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  additional_tags = var.tags
}
