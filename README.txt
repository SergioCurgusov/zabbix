Устанавливаем репозиторий:

Опять долго бился с Centos 7. Инструкция из лекции опять нерабочая. Плюнул на всё, делаю на Almalinux по документации с сайта zabbix.

Автоматизацию подготовки сервера осуществим посредством скрипта script.sh для vagrantfile.

Но и здесь не без приключений: оказалось, что локали (в том числе английскую) нужно доустанавливать. Изменил вагрант-файл для автоматизации.

mysql -uroot
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by 'password';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> SHOW DATABASES;
mysql> quit; 

zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
Вводим пароль: password


Выключаем опцию log_bin_trust_function_creators после импорта схемы базы данных

mysql -uroot
mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;

sed -i 's/'"$(cat /etc/zabbix/zabbix_server.conf | grep DBPassword=)"'/DBPassword=password/g' /etc/zabbix/zabbix_server.conf

sed -i '2s/#//' /etc/nginx/conf.d/zabbix.conf
sed -i '3s/#//' /etc/nginx/conf.d/zabbix.conf
sed -i '3s/example.com/zabbix.loc/' /etc/nginx/conf.d/zabbix.conf

systemctl restart zabbix-server zabbix-agent nginx php-fpm
systemctl enable zabbix-server zabbix-agent nginx php-fpm 

Входим через web-интерфейс: 192.168.38.200:8080

Настройка показана на скриншотах.

Авторизуемся:
login: Admin
password: zabbix






