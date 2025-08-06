@echo off
cd infrastructure
echo Getting server IP...
for /f "tokens=*" %%i in ('terraform output -raw instance_public_ip') do set SERVER_IP=%%i

echo Connecting to server at %SERVER_IP%...
ssh -i ~/.ssh/aws_key_pair.pem ubuntu@%SERVER_IP%