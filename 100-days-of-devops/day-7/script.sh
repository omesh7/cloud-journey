#!/bin/bash

SERVERS=(
  "tony@stapp01.stratos.xfusioncorp.com:Ir0nM@n"
  "steve@stapp02.stratos.xfusioncorp.com:Am3ric@"
  "banner@stapp03.stratos.xfusioncorp.com:BigGr33n"
)

# Generate SSH key for thor if it doesn't exist
if [ ! -f "$HOME/.ssh/id_rsa" ]; then
    echo "Generating SSH key for thor..."
    ssh-keygen -t rsa -N "" -f "$HOME/.ssh/id_rsa"
else
    echo "SSH key already exists. Skipping generation."
fi


for ENTRY in "${SERVERS[@]}"; do
  USERHOST=$(echo $ENTRY | cut -d: -f1)  
  PASS=$(echo $ENTRY | cut -d: -f2)       
  SERVER=$(echo $USERHOST | cut -d@ -f2)

  echo "setting up password-less access on $SERVER ..."
  sshpass -p "$PASS" ssh-copy-id -o StrictHostKeyChecking=no $USERHOST   

  if [ $? -eq 0 ]; then 
    echo "✅ Password-less SSH setup completed on $SERVER"
  else
    echo "❌ Failed to set up password-less SSH on $SERVER"
  fi
done
