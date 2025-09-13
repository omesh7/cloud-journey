# Essential outputs only - uncomment others when needed

# Instance information
# output "instance_ids" {
#   description = "List of EC2 instance IDs"
#   value       = module.base_infrastructure.instance_ids
# }

output "instance_public_ips" {
  description = "List of public IP addresses"
  value       = module.base_infrastructure.instance_public_ips
}

# output "instance_private_ips" {
#   description = "List of private IP addresses"
#   value       = module.base_infrastructure.instance_private_ips
# }

# output "instance_public_dns" {
#   description = "List of public DNS names"
#   value       = module.base_infrastructure.instance_public_dns
# }

# Detailed instance information
# output "instance_details" {
#   description = "Detailed information about created instances"
#   value       = module.base_infrastructure.instance_details
# }

# Security and access information
# output "security_group_id" {
#   description = "ID of the created security group"
#   value       = module.base_infrastructure.security_group_id
# }

# output "key_pair_name" {
#   description = "Name of the created SSH key pair"
#   value       = module.base_infrastructure.key_pair_name
# }

# AMI information
# output "ami_id" {
#   description = "ID of the AMI used for instances"
#   value       = module.base_infrastructure.ami_id
# }

# Ansible inventory outputs
# output "ansible_inventory_data" {
#   description = "Data structure for Ansible inventory generation"
#   value       = module.base_infrastructure.ansible_inventory_data
# }

# output "ansible_inventory" {
#   description = "Ansible inventory format output"
#   value       = module.base_infrastructure.ansible_inventory
# }
# SSH connection command
output "ssh_command" {
  description = "Ready-to-use SSH command to connect to the first instance"
  value       = length(module.base_infrastructure.instance_public_ips) > 0 ? "ssh -i ${path.root}/../../ssh/ansible-key ec2-user@${module.base_infrastructure.instance_public_ips[0]}" : "No instances available"
}
