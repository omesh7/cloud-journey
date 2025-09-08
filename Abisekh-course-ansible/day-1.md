# Ansible Day 1 - Introduction

## What is Ansible?

> Ansible is like a remote control for your servers, letting you set them up and manage them all at once instead of configuring each one by hand.

### Analogy
- **Terraform** → Infrastructure → Kitchen layout (walls, stove, sink built)
- **Ansible** → Configuration → Cooking inside that kitchen (recipes, ingredients, taste)

### Example Use Case
You have 10 servers, and you want all of them to have Apache installed and running on port 80.

With Ansible, you just write one simple playbook (like a recipe):
1. "Install Apache"
2. "Start Apache service"

Then you run that playbook, and Ansible takes care of connecting to each server (all 10) and doing all the steps for you automatically.

## Technical Details

- **Language**: Internally uses Python
- **Connection**: Uses SSH to connect to remote servers
- **Configuration**: Uses YAML for configuration files
- **Inventory**: Uses inventory file to list all servers

## Architecture

- **Control Node**: Machine where Ansible is installed
- **Managed Nodes**: Machines that are managed by the control node

## Key Components

- **Ad-hoc commands**: Run single command on multiple servers
- **Playbooks**: Run multiple commands in a file on multiple servers
- **Galaxy**: Download roles from Ansible Galaxy

## Why Ansible?

### The Problem
Sysadmins traditionally managed all updates and configurations manually, which was:
- Tedious and time-consuming
- Error-prone due to human involvement

### Previous Solutions
Tools like Chef and Puppet existed but had:
- Steep learning curve
- Required installing agents on each system

### Ansible's Advantage
- **Agentless**: No need to install anything on managed nodes
- **Simple**: Uses SSH for communication
- **Easy to learn**: YAML-based configuration

## Ansible vs Shell Scripting

### Idempotency
- **Ansible**: Idempotent → run multiple times, same result
- **Shell scripting**: Not idempotent → run multiple times, different result

### Programming Paradigm
- **Ansible**: Declarative → you declare what you want
- **Shell scripting**: Imperative → you tell how to do it

### Example Comparison

#### Ansible (Declarative)
What you're saying: "I want Apache installed and running"

Ansible figures out **HOW to do it based on the OS**: (automatically)
- If already installed → does nothing
- If not installed → installs it
- If stopped → starts it
- If running → does nothing

#### Shell Scripting (Imperative)
You have to write out all the steps yourself:
- Check if Apache is installed
- If not, install it
- Check if Apache is running
- If not, start it
- If running, do nothing

All by commands for each OS

## Installation

### Ubuntu/Debian
```bash
sudo apt update
sudo apt install ansible
```

### CentOS/RHEL
```bash
sudo yum install epel-release
sudo yum install ansible
```

### Using pip (All platforms)
```bash
pip install ansible
```

### Verify Installation
```bash
ansible --version
```

### Prerequisites
- Python 3.8+ on control node
- SSH access to managed nodes
- Python on managed nodes (usually pre-installed)
