Create a user named mariyam with a non-interactive shell on App Server 2.

stapp02	172.16.238.11	stapp02.stratos.xfusioncorp.com	steve	Am3ric@	Nautilus App 2

ssh steve@stapp02.stratos.xfusioncorp.com 

password: Am3ric@

//-----------------------------inside app 2

sudo useradd mariyam -s /sbin/nologin

getent passwd mariyam

DAY 1 - COMPLETED 