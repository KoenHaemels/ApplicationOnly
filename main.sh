#!/bin/bash
#Main script
sudo apt-get update 

#Installation apache2
sudo apt-get install apache2 -y
#Installation php
sudo apt-get install php libapache2-mod-php -y
#Clear any docs in /html and copy docs from Application into /html
sudo rm -f /var/www/html/* -r
sudo cp /var/InstallationApplicationAWS/WorkingSite/* /var/www/html/ -r -f
clear

#Installation S3fs
sudo apt-get install automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config -y
sudo git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
sudo ./autogen.sh
sudo ./configure
sudo make
sudo make install
cd ..
clear

#Create location bucket +rights
sudo mkdir /var/InstallationApplicationAWS/bucket
sudo chmod 757 /var/InstallationApplicationAWS/bucket
sudo chmod 777 /etc/fstab
sudo echo "test-stage-cvo /var/InstallationApplicationAWS/bucket fuse.s3fs _netdev,allow_other 0 0" >> /etc/fstab
clear
sudo mount /var/InstallationApplicationAWS/bucket

#Run tests
sudo chmod +x /var/InstallationApplicationAWS/Tests/test.sh
sudo chmod 777 /var/InstallationApplicationAWS/Tests/test.sh
sudo chmod 777 /var/InstallationApplicationAWS/Tests/configyamllint.yml
/var/InstallationApplicationAWS/Tests/test.sh

echo "Done"
