ssh to 3rd app

sudo yum install -y policycoreutils selinux-policy selinux-policy-targeted #found on google

sudo vi /etc/selinux/config

#change to
SELINUX=disabled


to check : 
sestatus

