sudo yum update -y

# MSSQL
## https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-red-hat?view=sql-server-2017

sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-preview.repo 
sudo yum install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup
systemctl status mssql-server
sudo firewall-cmd --zone=public --add-port=1433/tcp --permanent
sudo firewall-cmd --reload

sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo
sudo yum remove unixODBC-utf16 unixODBC-utf16-devel
sudo yum install -y mssql-tools unixODBC-devel
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc


# Plex
wget https://downloads.plex.tv/plex-media-server-new/1.16.3.1402-22929c8a2/redhat/plexmediaserver-1.16.3.1402-22929c8a2.x86_64.rpm
rpm -i plexmediaserver-1.16.3.1402-22929c8a2.x86_64.rpm

systemctl start plexmediaserver
systemctl enable plexmediaserver
systemctl status plexmediaserver

firewall-cmd --add-service=plexmediaserver --permanent
firewall-cmd --reload
firewall-cmd --list-all

chmod 777 <the foler you want>
## http://192.168.1.232:32400/web

# Containers
subscription-manager repos --enable rhel-7-server-extras-beta-rpms
yum -y install podman

podman pull gitlab/gitlab-ce
podman run --detach \
  --hostname gitlab.example.com \
  --publish 443:443 --publish 80:80 --publish 222:22 \
  --name gitlab \
  docker.io/gitlab/gitlab-ce:latest
