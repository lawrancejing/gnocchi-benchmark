yum -y install epel-release
yum -y install mariadb mariadb-server python-pip gcc python-devel net-tools gcc-c++ httpd mod_wsgi screen

pip install gnocchi[file,mysql] -i https://pypi.tuna.tsinghua.edu.cn/simple
pip install gnocchiclient -i https://pypi.tuna.tsinghua.edu.cn/simple

systemctl start mariadb.service
mysql -e "create database gnocchi; GRANT ALL PRIVILEGES ON gnocchi.* TO root@localhost IDENTIFIED BY 'password'"

cp -R etc/gnocchi /etc
chmod -R 777 etc/gnocchi
gnocchi-upgrade
cp etc/http/gnocchi.conf /etc/httpd/conf.d/
cp etc/http/app.wsgi /var/www
chmod 777 /var/www/app.wsgi
systemctl restart httpd
screen gnocchi-metricd
