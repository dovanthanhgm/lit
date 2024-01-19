cd ~/
sudo apt update -y && sudo apt upgrade -y
git clone https://github.com/dovanthanhgm/lit.git
mkdir code
cd lit
tar -zxvf django.tar.gz
tar -zxvf datasync_ui.tar.gz
tar -zxvf datasync_django.tar.gz
mv django ~/code/
mv datasync_ui ~/code/

sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.8 -y
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2
sudo apt install python3.8-dev python3.8-distutils -y
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
python -m pip install --upgrade pip
sudo rm get-pip.py

sudo apt-get install libkrb5-dev build-essential libsnappy-dev -y
python -m pip install psutil pykerberos python-snappy Twisted
sudo apt-get install pkg-config libmysqlclient-dev -y
export MYSQLCLIENT_CFLAGS="-I/usr/include/mysql"
export MYSQLCLIENT_LDFLAGS="-L/usr/lib/x86_64-linux-gnu -lmysqlclient -lzstd -lssl -lcrypto -lresolv -lm"
python -m pip install -r requirements1.txt
python -m pip install -r requirements2.txt

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password admin'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password admin'
sudo apt-get -y install mysql-server
sudo chmod -R 777 /var/run/mysqld
sudo service mysql restart
touch ~/.my.cnf
echo "[client]" > ~/.my.cnf
echo "user=root" >> ~/.my.cnf
echo "password=admin" >> ~/.my.cnf
mysql -e "create database datasync_django;"
mysql datasync_django < ./datasync_django.sql
mysql -e "use datasync_django;source datasync_django.sql;"

sudo apt install curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm install 16.0.0
nvm use 16.0.0
npm i yarn -g

cd ~/code/datasync_ui/
yarn

mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -b 2048 -f id_rsa -P ""
echo "Host bitbucket.org" > config
echo "  AddKeysToAgent yes" >> config
echo "  IdentityFile ~/.ssh/id_rsa" >> config

cd ~/code/
