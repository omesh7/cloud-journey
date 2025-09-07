#!/bin/bash

SERVERS=(
  "tony@stapp01.stratos.xfusioncorp.com:Ir0nM@n"
  "steve@stapp02.stratos.xfusioncorp.com:Am3ric@"
  "banner@stapp03.stratos.xfusioncorp.com:BigGr33n"
)

[ ! -f "$HOME/.ssh/id_rsa" ] && ssh-keygen -t rsa -N "" -f "$HOME/.ssh/id_rsa"

for ENTRY in "${SERVERS[@]}"; do
  USERHOST=$(echo $ENTRY | cut -d: -f1)  
  PASS=$(echo $ENTRY | cut -d: -f2)       

  sshpass -p "$PASS" ssh-copy-id -o StrictHostKeyChecking=no $USERHOST   

  ssh $USERHOST << EOF
    # Install Apache if missing
    command -v httpd >/dev/null 2>&1 || echo "$PASS" | sudo -S dnf install -y httpd
    
    # Configure Apache to listen on port 8084
    echo "$PASS" | sudo -S sed -i 's/^Listen .*/Listen 8084/' /etc/httpd/conf/httpd.conf
    
    # Start and enable Apache service
    echo "$PASS" | sudo -S systemctl enable httpd
    echo "$PASS" | sudo -S systemctl start httpd
EOF
done