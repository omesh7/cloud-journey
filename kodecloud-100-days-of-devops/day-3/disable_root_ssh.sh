#!/bin/bash
SERVERS=(
  "tony@stapp01.stratos.xfusioncorp.com:Ir0nM@n"
  "steve@stapp02.stratos.xfusioncorp.com:Am3ric@"
  "banner@stapp03.stratos.xfusioncorp.com:BigGr33n"
)

for ENTRY in "${SERVERS[@]}"; do
  USERHOST=$(echo $ENTRY | cut -d: -f1)   # trunk it before colon: here => tony@stapp01.stratos.xfusioncorp.com  => user@host
  PASS=$(echo $ENTRY | cut -d: -f2)       # trunk it after colon: here => Ir0nM@n =>  password
  SERVER=$(echo $USERHOST | cut -d@ -f2)  # trunk it after 1'st @ here => stapp01.stratos.xfusioncorp.com => host

  echo "🔹 Updating $SERVER ..."

:<<'
notes:
# -o StrictHostKeyChecking=no -> disables the interactive prompt

sudo sed => stream editor  

-i => in place editing (directly edit the file)

`s/^#*PermitRootLogin.*/PermitRootLogin no/` => basically find and replace 
 This sed command finds any line starting with optional '#' and 'PermitRootLogin', then replaces it with 'PermitRootLogin no'

 && sudo systemctl restart sshd => if previous command is successful then restart sshd service

'
  sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no $USERHOST \
    "echo '$PASS' | sudo -S sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config && echo '$PASS' | sudo -S systemctl restart sshd"

  if [ $? -eq 0 ]; then # $? => checks the exit status of the last executed command like success or failure 0 = success, anything else = failure
    echo "✅ Root SSH login disabled on $SERVER"
  else
    echo "❌ Failed on $SERVER"
  fi
done
'

