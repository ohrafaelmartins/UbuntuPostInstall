#!/bin/bash

apps=(curl net-tools php php-mysql php-xdebug composer nginx docker docker-compose inkscape)

for pkge in "${apps[@]}"
do
    echo "Checking for $pkge"
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $pkge |grep "install ok installed") 
    if [ "" == "$PKG_OK" ]; then
        sudo apt install $pkge -y
    fi
done

sudo service apache2 stop
sudo apt remove --purge apache2* -y > /dev/null

sudo ufw allow OpenSSH
sudo ufw allow 'Nginx HTTP'
sudo ufw enable
sudo ufw status

ipServer=$(sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1');
sed -i 's/server_name _;/server_name '$ipServer';/g' nginx-config  > /dev/null

sudo touch /var/www/html/index.php
sudo echo '<?php phpinfo(); ?>' | sudo tee /var/www/html/index.php > /dev/null

sudo cp -f /etc/nginx/sites-available/default /etc/nginx/sites-available/default-bkp
sudo cp -f nginx-config /etc/nginx/sites-available/default

sudo systemctl restart php7.3-fpm
sudo service nginx stop
sudo service nginx start

sudo snap install code --classic > /dev/null
sudo snap install chromium > /dev/null
sudo snap install spotify > /dev/null

wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update > /dev/null
sudo apt-get install apt-transport-https -y > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install dotnet-sdk-2.2=2.2.206-1

curl https://s3-us-west-1.amazonaws.com/codenation-cli/latest/codenation_linux.tar.gz | tar xvz  
sudo mv codenation /usr/local/bin

sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

reboot
