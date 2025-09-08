question:
In a bid to automate backup processes, the xFusionCorp Industries sysadmin team has developed a new bash script named xfusioncorp.sh. While the script has been distributed to all necessary servers, it lacks executable permissions on App Server 3 within the Stratos Datacenter.



Your task is to grant executable permissions to the /tmp/xfusioncorp.sh script on App Server 3. Additionally, ensure that all users have the capability to execute it.



ssh banner@stapp03.stratos.xfusioncorp.com

BigGr33n

[banner@stapp03 ~]$ ls -la /tmp/
total 48
drwxrwxrwt 1 root root  4096 Aug 26 03:16 .
drwxr-xr-x 1 root root 12288 Aug 26 03:16 ..
drwxrwxrwt 2 root root  4096 Aug 26 03:12 .ICE-unix
drwxrwxrwt 2 root root  4096 Aug 26 03:12 .X11-unix
drwxrwxrwt 2 root root  4096 Aug 26 03:12 .XIM-unix
drwxrwxrwt 2 root root  4096 Aug 26 03:12 .font-unix
drwx------ 3 root root  4096 Aug 26 03:12 systemd-private-1e613337cfbc49dda6222fbadd6c3403-dbus-broker.service-wjLtsQ
drwx------ 3 root root  4096 Aug 26 03:16 systemd-private-1e613337cfbc49dda6222fbadd6c3403-systemd-hostnamed.service-08IVfr
drwx------ 3 root root  4096 Aug 26 03:12 systemd-private-1e613337cfbc49dda6222fbadd6c3403-systemd-logind.service-r0ZXK6
---------- 1 root root    40 Aug 26 03:12 xfusioncorp.sh => no permissions at all

cd /tmp/

sudo chmod a+rx xfusioncorp.sh  => gives all users to execute