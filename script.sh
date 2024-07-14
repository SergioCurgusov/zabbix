#!/bin/bash

# доустанавливаем пакеты:

dnf install -y nano mc

# доустановим локали
dnf install -y glibc-all-langpacks

# устанавливаем репозиторий

rpm -Uvh https://repo.zabbix.com/zabbix/7.0/alma/9/x86_64/zabbix-release-7.0-3.el9.noarch.rpm
dnf clean all 

# установим maradb

dnf install mariadb-server -y
systemctl enable mariadb.service
systemctl start mariadb.service

# установим Zabbix сервер, веб-интерфейс и агент 

dnf install -y zabbix-server-mysql zabbix-web-mysql zabbix-nginx-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent 
