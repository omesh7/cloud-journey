The production support team of xFusionCorp Industries has deployed some of the latest monitoring tools to keep an eye on every service, application, etc. running on the systems. One of the monitoring systems reported about Apache service unavailability on one of the app servers in Stratos DC.



Identify the faulty app host and fix the issue. Make sure Apache service is up and running on all app hosts. They might not have hosted any code yet on these servers, so you don’t need to worry if Apache isn’t serving any pages. Just make sure the service is up and running. Also, make sure Apache is running on port 8084 on all app servers.


summary: 
# Tasks:
1. Check Apache service status on all app servers
2. Identify which app server has Apache down
3. Fix Apache service on faulty server
4. Verify Apache is running on port 8084 on all servers
5. Ensure Apache service is up and running on all app hosts



first lets goto 1st app:

appache status:
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Sun 2025-09-07 14:12:07 UTC; 7s ago
     Docs: man:httpd(8)
           man:apachectl(8)
  Process: 1309 ExecStop=/bin/kill -WINCH ${MAINPID} (code=exited, status=1/FAILURE)
  Process: 1308 ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND (code=exited, status=1/FAILURE)
 Main PID: 1308 (code=exited, status=1/FAILURE)



 [tony@stapp01 ~]$ sudo ss -tulpn | grep :8084
tcp    LISTEN     0      10     127.0.0.1:8084                  *:*                   users:(("sendmail",pid=555,fd=4))


sendmail again, lets stop it

[tony@stapp01 ~]$ sudo systemctl stop sendmail

[tony@stapp01 ~]$ sudo systemctl disable sendmail

[tony@stapp01 ~]$ sudo systemctl start httpd

[tony@stapp01 ~]$ sudo systemctl status httpd

● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since Sun 2025-09-07 14:14:40 UTC; 13s ago
     Docs: man:httpd(8)
           man:apachectl(8)

[tony@stapp01 ~]$ sudo systemctl enable httpd #on starup


curl http://localhost:8084 also working as expected


//----------------

for second:

thor@jumphost ~$ ssh steve@stapp02.stratos.xfusioncorp.com
[steve@stapp02 ~]$ sudo systemctl status httpd.service
[sudo] password for steve: 
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
     Active: active (running) since Sun 2025-09-07 14:00:30 UTC; 16min ago
       Docs: man:httpd.service(8)
   Main PID: 1679 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 177 (limit: 411434)
     Memory: 19.0M
     CGroup: /docker/7cf8c96277abffeed3b9501477a3ff3ff99e3abd394c2ab5cd07d6ac7404e9ff/system.slice/httpd.service
             ├─1679 /usr/sbin/httpd -DFOREGROUND
             ├─1686 /usr/sbin/httpd -DFOREGROUND
             ├─1687 /usr/sbin/httpd -DFOREGROUND
             ├─1688 /usr/sbin/httpd -DFOREGROUND
             └─1689 /usr/sbin/httpd -DFOREGROUND

Sep 07 14:15:19 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
Sep 07 14:15:29 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
Sep 07 14:15:39 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
Sep 07 14:15:49 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
Sep 07 14:15:59 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
Sep 07 14:16:09 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
Sep 07 14:16:19 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
Sep 07 14:16:30 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
Sep 07 14:16:39 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
Sep 07 14:16:50 stapp02.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message from PID 1679 (READY=1, ST>
lines 1-25/25 (END)
^C
[steve@stapp02 ~]$ sudo ss -tulpn | grep :8084
tcp   LISTEN 0      511          0.0.0.0:8084       0.0.0.0:*    users:(("httpd",pid=1689,fd=3),("httpd",pid=1688,fd=3),("httpd",pid=1687,fd=3),("httpd",pid=1679,fd=3))
[steve@stapp02 ~]$ 

its working,


//-------------------


3rd:

also running, so thats it, i guess 