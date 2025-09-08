quest:

The Nautilus application development team recently finished the beta version of one of their Java-based applications, which they are planning to deploy on one of the app servers in Stratos DC. After an internal team meeting, they have decided to use the tomcat application server. Based on the requirements mentioned below complete the task:



a. Install tomcat server on App Server 2.

b. Configure it to run on port 8082.

c. There is a ROOT.war file on Jump host at location /tmp.


Deploy it on this tomcat server and make sure the webpage works directly on base URL i.e curl http://stapp02:8082


what is tomcat: 

 - A program that helps run websites or web applications built with Java.
 
 [mini web server specifically for Java-based apps]



 a => 

 ssh steve@stapp02.stratos.xfusioncorp.com 

 =>  yum install -y java-11-openjdk 

   verify: java -version

   # This command creates a new user account for running Tomcat:
# -m : Creates the user's home directory if it doesn't exist
# -U : Creates a group with same name as the user
# -d /opt/tomcat : Sets the home directory to /opt/tomcat 
# -s /bin/false : Sets the shell to /bin/false (no login shell access)
# tomcat : The username being created

sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat 

verify: cat /etc/passwd

lets install tomcat:

latest version : 9.0.109

commands: 

cd /tmp
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.109/bin/apache-tomcat-9.0.109.tar.gz
sudo mkdir /opt/tomcat #ignore if already there
sudo tar xf apache-tomcat-9.0.109.tar.gz -C /opt/tomcat --strip-components=1


sudo chown -R tomcat: /opt/tomcat


sudo sh -c 'chmod +x /opt/tomcat/bin/*.sh'

b. change the port to 8080 to 8082:

sudo vi /opt/tomcat/conf/server.xml 

find: <Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />

change 8080 => 8082, save it 

restart it:

sudo -u tomcat /opt/tomcat/bin/shutdown.sh

sudo -u tomcat /opt/tomcat/bin/startup.sh


---lets test it: curl http://stapp02:8082

-> it worked, and also after exiting to jump host it worked, but its a => `Tomcat Default Welcome Page`

we need put the ROOT.war inside the `App Server 2` make it run not the default app

c. copy the ROOT.war from jump host to app server 2:

ROOT.war = a ready-to-run website inside a single file that Tomcat serves at the main URL


in the jump host:

scp /tmp/ROOT.war steve@stapp02.stratos.xfusioncorp.com:/tmp/


sudo -u tomcat /opt/tomcat/bin/shutdown.sh 
sudo rm -rf /opt/tomcat/webapps/ROOT #default thing, letsremove it
sudo cp /tmp/ROOT.war /opt/tomcat/webapps/ROOT.war 
sudo chown tomcat: /opt/tomcat/webapps/ROOT.war
sudo -u tomcat /opt/tomcat/bin/startup.sh #start again

curl http://stapp02:8082 => 

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>SampleWebApp</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h2>Welcome to xFusionCorp Industries!</h2>
        <br>
    
    </body>
</html>

# it worked :)
