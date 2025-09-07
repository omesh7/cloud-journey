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
    LB_IP=\$(getent hosts stlb01 | awk '{print \$1}')
    
    # Install iptables
    echo "$PASS" | sudo -S dnf install -y iptables iptables-services
    echo "$PASS" | sudo -S systemctl enable iptables && sudo -S systemctl start iptables
    
    # Block port 3001 except from LB
    echo "$PASS" | sudo -S iptables -F
    echo "$PASS" | sudo -S iptables -A INPUT -p tcp -s \$LB_IP --dport 3001 -j ACCEPT
    echo "$PASS" | sudo -S iptables -A INPUT -p tcp --dport 3001 -j DROP
    
    # Save rules for reboot persistence
    echo "$PASS" | sudo -S service iptables save
EOF
done