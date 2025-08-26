

#maria db

ssh to db server then:


sudo systemctl start mariadb 

error:

Job for mariadb.service failed because the control process exited with error code.
See "systemctl status mariadb.service" and "journalctl -xeu mariadb.service" for details.

systemctl status mariadb.service :

 mariadb.service - MariaDB 10.5 database server
     Loaded: loaded (/usr/lib/systemd/system/mariadb.service; disabled; preset: disabled)
     Active: failed (Result: exit-code) since Tue 2025-08-26 05:29:18 UTC; 46s ago
   Duration: 5.751s
       Docs: man:mariadbd(8)
             https://mariadb.com/kb/en/library/systemd/
   Main PID: 3487 (code=exited, status=1/FAILURE)
     Status: "MariaDB server is down"

Aug 26 05:29:18 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Child 3487 belongs to mariadb.service.
Aug 26 05:29:18 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Main process exited, code=exited, status=1/FAILURE
Aug 26 05:29:18 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Failed with result 'exit-code'.
Aug 26 05:29:18 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Service will not restart (restart setting)
Aug 26 05:29:18 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Changed start -> failed
Aug 26 05:29:18 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Job 449 mariadb.service/start finished, result=failed
Aug 26 05:29:18 stdb01.stratos.xfusioncorp.com systemd[1]: Failed to start MariaDB 10.5 database server.
Aug 26 05:29:18 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Unit entered failed state.
Aug 26 05:29:55 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Changed dead -> failed
Aug 26 05:29:58 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Changed dead -> failed


#found nothing 


journalctl -xeu mariadb.service:


there was a line: [Warning] Can't create test file /var/lib/mysql/stdb01.lower-test Aug 26 05:27:31

might be permission issue


checking: ownership is correct mysql 

chnage permission: sudo chmod 750 /var/lib/mysql

sudo systemctl start mariadb 

and it runs:

systemctl status mariadb


 mariadb.service - MariaDB 10.5 database server
     Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; preset: disabled)
     Active: active (running) since Tue 2025-08-26 05:32:02 UTC; 5min ago
       Docs: man:mariadbd(8)
             https://mariadb.com/kb/en/library/systemd/
    Process: 4507 ExecStartPre=/usr/libexec/mariadb-check-socket (code=exited, status=0/SUCCESS)
    Process: 4541 ExecStartPre=/usr/libexec/mariadb-prepare-db-dir mariadb.service (code=exited, status=0/SUCCESS)
    Process: 4671 ExecStartPost=/usr/libexec/mariadb-check-upgrade (code=exited, status=0/SUCCESS)
   Main PID: 4636 (mariadbd)
     Status: "Taking your SQL requests now..."
      Tasks: 8 (limit: 411434)
     Memory: 73.4M
     CGroup: /docker/c4d64ecf9f2acc76867814ea0a222ea72305f5392ddae40d3857375b17e3549a/system.slice/mariadb.service
             └─4636 /usr/libexec/mariadbd --basedir=/usr


mariadb service is up and running in db server