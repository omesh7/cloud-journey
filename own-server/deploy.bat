@echo off
echo Creating AWS EC2 instance...

cd infrastructure

echo Initializing Terraform...
terraform init

echo Planning deployment...
terraform plan

echo Applying configuration...
terraform apply -auto-approve

echo.
echo Server created! Getting connection details...
terraform output ssh_command

echo.
echo To connect to your server, copy and run the SSH command above.
echo Make sure your private key file has correct permissions.