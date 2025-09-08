#!/bin/bash

SERVERS=(
    "tony@stapp01.stratos.xfusioncorp.com:Ir0nM@n"
    "steve@stapp02.stratos.xfusioncorp.com:Am3ric@"
    "banner@stapp03.stratos.xfusioncorp.com:BigGr33n"
)

for ENTRY in "${SERVERS[@]}"; do
    USERHOST=$(echo "$ENTRY" | cut -d: -f1)
    PASS=$(echo "$ENTRY" | cut -d: -f2)
    SERVER=$(echo "$USERHOST" | cut -d@ -f2)

    echo "🔹 Updating Cron on $SERVER ..."

    sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no $USERHOST "
        echo '$PASS' | sudo -S yum install -y cronie &&
        echo '$PASS' | sudo -S systemctl start crond &&
        echo '$PASS' | sudo -S systemctl enable crond &&
        (crontab -u root -l 2>/dev/null; echo '*/5 * * * * echo hello > /tmp/cron_text') | sudo crontab -u root -
    "

    if [ $? -eq 0 ]; then
        echo "✅ Cron job added on $SERVER"
    else
        echo "❌ Failed on $SERVER"
    fi
done
