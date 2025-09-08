#!/bin/bash

# Get terraform output and extract IPs
cd infrastructure
NODE1_IP=$(terraform output -json managed_nodes_ips | jq -r '.["node-1"].public_ip')
NODE2_IP=$(terraform output -json managed_nodes_ips | jq -r '.["node-2"].public_ip')
NODE3_IP=$(terraform output -json managed_nodes_ips | jq -r '.["node-3"].public_ip')

# Go back to day-2 directory
cd ..

# Update inventory.ini with actual IPs
sed -i "s/<PUBLIC_IP_1>/$NODE1_IP/g" inventory.ini
sed -i "s/<PUBLIC_IP_2>/$NODE2_IP/g" inventory.ini
sed -i "s/<PUBLIC_IP_3>/$NODE3_IP/g" inventory.ini

echo "Updated inventory.ini with:"
echo "node-1: $NODE1_IP"
echo "node-2: $NODE2_IP" 
echo "node-3: $NODE3_IP"