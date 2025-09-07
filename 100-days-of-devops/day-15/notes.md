The system admins team of xFusionCorp Industries needs to deploy a new application on App Server 3 in Stratos Datacenter. They have some pre-requites to get ready that server for application deployment. Prepare the server as per requirements shared below:



1. Install and configure nginx on App Server 3.


2. On App Server 3 there is a self signed SSL certificate and key present at location /tmp/nautilus.crt and /tmp/nautilus.key. Move them to some appropriate location and deploy the same in Nginx.


3. Create an index.html file with content Welcome! under Nginx document root.


4. For final testing try to access the App Server 3 link (either hostname or IP) from jump host using curl command. For example curl -Ik https://<app-server-ip>/.


//---------------------------


Notes:

sudo dnf update -y; sudo dnf install nginx -y #update and install ngnix

sudo systemctl enable nginx
sudo systemctl start nginx


sudo systemctl status nginx


● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: disabled)
     Active: active (running) since Sun 2025-09-07 14:23:43 UTC; 92ms ago


2 => move ssl to appropriate location: 

    appropriate location is : `/etc/nginx/ssl`

    lets check if that directory exists: 
    [banner@stapp03 ~]$ ls -la /etc/nginx/
total 88
drwxr-xr-x 4 root root 4096 Sep  7 14:23 .
drwxr-xr-x 1 root root 4096 Sep  7 14:23 ..
drwxr-xr-x 2 root root 4096 Jun 19 09:39 conf.d
drwxr-xr-x 2 root root 4096 Jun 19 09:39 default.d
-rw-r--r-- 1 root root 1077 Jun 19 09:39 fastcgi.conf
-rw-r--r-- 1 root root 1077 Jun 19 09:39 fastcgi.conf.default
-rw-r--r-- 1 root root 1007 Jun 19 09:39 fastcgi_params
-rw-r--r-- 1 root root 1007 Jun 19 09:39 fastcgi_params.default
-rw-r--r-- 1 root root 2837 Jun 19 09:39 koi-utf
-rw-r--r-- 1 root root 2223 Jun 19 09:39 koi-win
-rw-r--r-- 1 root root 5231 Jun 19 09:39 mime.types
-rw-r--r-- 1 root root 5231 Jun 19 09:39 mime.types.default
-rw-r--r-- 1 root root 2334 Jun 19 09:38 nginx.conf
-rw-r--r-- 1 root root 2656 Jun 19 09:39 nginx.conf.default
-rw-r--r-- 1 root root  636 Jun 19 09:39 scgi_params
-rw-r--r-- 1 root root  636 Jun 19 09:39 scgi_params.default
-rw-r--r-- 1 root root  664 Jun 19 09:39 uwsgi_params
-rw-r--r-- 1 root root  664 Jun 19 09:39 uwsgi_params.default
-rw-r--r-- 1 root root 3610 Jun 19 09:39 win-utf
[banner@stapp03 ~]$ 

nope, so lets create one:

sudo mkdir /etc/nginx/ssl

lets move them to correct folder 
sudo mv /tmp/nautilus.crt /etc/nginx/ssl/
sudo mv /tmp/nautilus.key /etc/nginx/ssl/

[banner@stapp03 ~]$ ls -la /etc/nginx/ssl
total 16
drwxr-xr-x 2 root root 4096 Sep  7 14:26 .
drwxr-xr-x 5 root root 4096 Sep  7 14:25 ..
-rw-r--r-- 1 root root 2170 Sep  7 14:20 nautilus.crt
-rw-r--r-- 1 root root 3267 Sep  7 14:20 nautilus.key
[banner@stapp03 ~]$ 

lets give appropriate peermisions => 

sudo chmod 600 /etc/nginx/ssl/nautilus.key #read+write(4+2) for owner only, rest no permissions
sudo chmod 644 /etc/nginx/ssl/nautilus.crt #read+write(4+2) for owner and read(4) for groups and others

/------------------------

taks 3: sudo bash -c 'echo "Welcome!" > /usr/share/nginx/html/index.html' #Create an index.html file with content Welcome! under Nginx document root.


lets try to access it, 

[banner@stapp03 ~]$ sudo bash -c 'echo "Welcome!" > /usr/share/nginx/html/index.html'
[banner@stapp03 ~]$ cat /usr/share/nginx/html/index.html
Welcome!



[banner@stapp03 ~]$ curl -Ik https://localhost
curl: (7) Failed to connect to localhost port 443: Connection refused
[banner@stapp03 ~]$ curl -Ik https://localhostsudo ss -tulpn | grep :8080
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (6) Could not resolve host: localhostsudo
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (6) Could not resolve host: ss


[banner@stapp03 ~]$ sudo ss -tulpn | grep :8080 


[banner@stapp03 ~]$ sudo ss -tulpn | grep :80
tcp   LISTEN 0      511          0.0.0.0:80         0.0.0.0:*    users:(("nginx",pid=3644,fd=6),("nginx",pid=3643,fd=6),("nginx",pid=3642,fd=6),("nginx",pid=3641,fd=6),("nginx",pid=3640,fd=6),("nginx",pid=3639,fd=6),("nginx",pid=3638,fd=6),("nginx",pid=3637,fd=6),("nginx",pid=3636,fd=6),("nginx",pid=3635,fd=6),("nginx",pid=3634,fd=6),("nginx",pid=3633,fd=6),("nginx",pid=3632,fd=6),("nginx",pid=3631,fd=6),("nginx",pid=3630,fd=6),("nginx",pid=3629,fd=6),("nginx",pid=3628,fd=6))
tcp   LISTEN 0      511             [::]:80            [::]:*    users:(("nginx",pid=3644,fd=7),("nginx",pid=3643,fd=7),("nginx",pid=3642,fd=7),("nginx",pid=3641,fd=7),("nginx",pid=3640,fd=7),("nginx",pid=3639,fd=7),("nginx",pid=3638,fd=7),("nginx",pid=3637,fd=7),("nginx",pid=3636,fd=7),("nginx",pid=3635,fd=7),("nginx",pid=3634,fd=7),("nginx",pid=3633,fd=7),("nginx",pid=3632,fd=7),("nginx",pid=3631,fd=7),("nginx",pid=3630,fd=7),("nginx",pid=3629,fd=7),("nginx",pid=3628,fd=7))

[banner@stapp03 ~]$ curl -Ik http://localhost/
HTTP/1.1 200 OK
Server: nginx/1.20.1
Date: Sun, 07 Sep 2025 14:32:12 GMT
Content-Type: text/html
Content-Length: 9
Last-Modified: Sun, 07 Sep 2025 14:30:12 GMT
Connection: keep-alive
ETag: "68bd96f4-9"
Accept-Ranges: bytes

#it runs but on http only 

#to access on https we need to configure ssl in nginx conf file

https on port 443 : edit /etc/nginx/conf.d/ssl.conf

server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate /etc/nginx/ssl/nautilus.crt;
    ssl_certificate_key /etc/nginx/ssl/nautilus.key;

    root /usr/share/nginx/html;
    index index.html;

    # Optional security headers
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
}

echo "Welcome!" | sudo tee /usr/share/nginx/html/index.html

sudo systemctl restart nginx

[banner@stapp03 ~]$ curl -Ik https://localhost/
HTTP/1.1 200 OK
Server: nginx/1.20.1
Date: Sun, 07 Sep 2025 14:38:32 GMT
Content-Type: text/html
Content-Length: 9
Last-Modified: Sun, 07 Sep 2025 14:37:30 GMT
Connection: keep-alive
ETag: "68bd98aa-9"
Accept-Ranges: bytes

[banner@stapp03 ~]$ 

so it works, [i guess]

#---------------------------

lets try this:

For final testing try to access the App Server 3 link (either hostname or IP) from jump host using curl command. For example curl -Ik https://<app-server-ip>/.

curl -Ik https://172.16.238.12 => works
curl -Ik https://stapp03.stratos.xfusioncorp.com => works

#---------------------------