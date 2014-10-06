#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password yourpassword'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password yourpassword'
sudo apt-get -y install mysql-server
sudo apt-get -y install vim 2> /dev/null
echo "installing python requirements"

sudo apt-get --yes install python-pip
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
sudo apt-get --yes install python-dev libmysqlclient-dev
sudo pip install -r /vagrant/requirements.txt

if [ ! -f /var/log/dbinstalled ];
then
    echo "CREATE USER 'vagrant'@'localhost'" | mysql -uroot -pyourpassword
    echo "CREATE DATABASE yourdbname" | mysql -uroot -pyourpassword
    echo "GRANT ALL ON yourdbname.* TO 'vagrant'@'localhost'" | mysql -uroot -pyourpassword
    echo "flush privileges" | mysql -uroot -pyourpassword
    touch /var/log/dbinstalled
fi



sudo apt-get install -y git 2> /dev/null