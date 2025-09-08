# Ansible Day 2 - Setup and Inventory

## Infrastructure Setup

The infrastructure is created using Terraform with 3 CentOS managed nodes.

## Inventory Configuration

Create `inventory.ini` file:

```ini
[webservers]
node-1 ansible_host=<PUBLIC_IP_1> ansible_user=centos
node-2 ansible_host=<PUBLIC_IP_2> ansible_user=centos

[databases]
node-3 ansible_host=<PUBLIC_IP_3> ansible_user=centos

[all:vars]
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

## Getting Server IPs

After running `terraform apply`, get the IPs:

```bash
terraform output managed_nodes_ips
```

Replace `<PUBLIC_IP_X>` in inventory.ini with actual IPs from the output.

## Testing Connection

Test connectivity to all nodes:

```bash
ansible all -i inventory.ini -m ping
```

Test specific groups:

```bash
ansible webservers -i inventory.ini -m ping
ansible databases -i inventory.ini -m ping
```

## Inventory Groups Explained

- **webservers**: Group for web application servers (node-1, node-2)
- **databases**: Group for database servers (node-3)
- **all:vars**: Variables applied to all hosts
  - `ansible_ssh_private_key_file`: Path to SSH private key
  - `ansible_ssh_common_args`: SSH options to skip host key checking

## Prerequisites

1. SSH key pair generated on control node:
   ```bash
   ssh-keygen -t rsa -b 4096
   ```

2. Ansible installed on control node (your machine)

3. Terraform applied to create infrastructure

## Next Steps

- Test ad-hoc commands
- Create first playbook
- Explore Ansible modules