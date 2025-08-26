#!/bin/bash

# Install zip
sudo yum install -y zip 

# Create backup directory
sudo mkdir -p /backup 

# Create zip archive
cd /var/www/html && zip -r /backup/xfusioncorp_news.zip news/

# Copy to Nautilus server
scp /backup/xfusioncorp_news.zip clint@stbkp01.stratos.xfusioncorp.com:/backup/

echo "Backup completed!"