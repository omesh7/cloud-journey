@echo off
cd infrastructure

REM Get terraform output and extract IPs
for /f "tokens=*" %%i in ('terraform output -json managed_nodes_ips ^| jq -r ".\"node-1\".public_ip"') do set NODE1_IP=%%i
for /f "tokens=*" %%i in ('terraform output -json managed_nodes_ips ^| jq -r ".\"node-2\".public_ip"') do set NODE2_IP=%%i
for /f "tokens=*" %%i in ('terraform output -json managed_nodes_ips ^| jq -r ".\"node-3\".public_ip"') do set NODE3_IP=%%i

cd ..

REM Update inventory.ini with actual IPs
powershell -Command "(Get-Content inventory.ini) -replace '<PUBLIC_IP_1>', '%NODE1_IP%' | Set-Content inventory.ini"
powershell -Command "(Get-Content inventory.ini) -replace '<PUBLIC_IP_2>', '%NODE2_IP%' | Set-Content inventory.ini"
powershell -Command "(Get-Content inventory.ini) -replace '<PUBLIC_IP_3>', '%NODE3_IP%' | Set-Content inventory.ini"

echo Updated inventory.ini with:
echo node-1: %NODE1_IP%
echo node-2: %NODE2_IP%
echo node-3: %NODE3_IP%