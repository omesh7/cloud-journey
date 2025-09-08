
#inside scripts folder: create if not there: sudo mkdir -p /scripts

#place news_backup.sh

sudo chmod +x /scripts/news_backup.sh #make it executable


#have rsa 

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa 
ssh-copy-id clint@stbkp01.stratos.xfusioncorp.com #passwordless logins to a remote server


/scripts/news_backup.sh #execute it