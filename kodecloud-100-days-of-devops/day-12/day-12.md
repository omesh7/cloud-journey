Our monitoring tool has reported an issue in Stratos Datacenter. One of our app servers has an issue, as its Apache service is not reachable on port 6200 (which is the Apache port). The service itself could be down, the firewall could be at fault, or something else could be causing the issue.



Use tools like telnet, netstat, etc. to find and fix the issue. Also make sure Apache is reachable from the jump host without compromising any security settings.

Once fixed, you can test the same using command curl http://stapp01:6200 command from jump host.

Note: Please do not try to alter the existing index.html code, as it will lead to task failure.

a. fix the apache thing

lets ssh to stapp1

ssh tony@stapp01.stratos.xfusioncorp.com  : Ir0nM@n


# This command shows all active network connections and listening ports
# Breaking down the netstat output:

# -t: Show TCP connections
# -u: Show UDP connections
# -l: Show only listening sockets
# -n: Show numerical addresses instead of resolving hostnames
# -p: Show the PID and name of the process

sudo netstat -tulnp #list all network conn and listening ports

//----------

Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      312/sshd            
tcp        0      0 127.0.0.1:6200          0.0.0.0:*               LISTEN      450/sendmail: accep 
tcp        0      0 127.0.0.11:41387        0.0.0.0:*               LISTEN      -                   
tcp6       0      0 :::22                   :::*                    LISTEN      312/sshd            
udp        0      0 127.0.0.11:51735        0.0.0.0:*                           -       


=> sendmail is using port 6200 instead of apache

what is sendMail: Sendmail is a widely used Mail Transfer Agent (MTA) program that routes and delivers email messages between computers

sudo systemctl status sendmail


its running => lets stop it and stop our thing

sudo systemctl stop sendmail

sudo systemctl disable sendmail

sudo systemctl status sendmail => check it => inactive (dead)

sudo systemctl start httpd

sudo systemctl status httpd => active (running)

[root@stapp01 ~]# sudo netstat -tulnp #list all network conn and listening ports
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      312/sshd            
tcp        0      0 0.0.0.0:6200            0.0.0.0:*               LISTEN      1072/httpd        # working  as expected    
tcp        0      0 127.0.0.11:41387        0.0.0.0:*               LISTEN      -                   
tcp6       0      0 :::22                   :::*                    LISTEN      312/sshd            
udp        0      0 127.0.0.11:51735        0.0.0.0:*

curl http://stapp01:6200 => gives some html doc [i guess its exepected output]

lets test in jumphost: nope it doesnt work

let goto stapp1 and check for iptables # which control network traffic

sudo iptables -L -n # Lists all current firewall rules with numeric output
=> :

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
ACCEPT     icmp --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0           
ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            state NEW tcp dpt:22
REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         
REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         
# Warning: iptables-legacy tables present, use iptables



=> port 6200 is not allowed in firewall

lets allow it:

sudo iptables -I INPUT -p tcp --dport 6200 -j ACCEPT # Adds a firewall rule to allow incoming TCP traffic on port 6200 

now lets check on jumphost:

curl http://stapp01:6200

=> works as expected
