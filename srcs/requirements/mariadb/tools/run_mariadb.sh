#!/bin/bash

mkdir -p /run/mysqld

chown -R mysql:mysql /run/mysqld

ls /var/lib/mysql

# Listen to all ports to be able to receive wordpress requests
echo "bind-address=0.0.0.0" >> /etc/mysql/mariadb.conf.d/50-server.cnf

WP_ADMIN_PASSWORD=$(cat $DB_ADMIN_PASSWORD_FILE)
WP_ROOT_PASSWORD=$(cat $DB_ROOT_PASSWORD_FILE)

mariadbd --user=mysql --bootstrap <<EOF
	USE mysql;
	FLUSH PRIVILEGES;

	CREATE DATABASE IF NOT EXISTS $DB_NAME;
	CREATE USER '$DB_ADMIN_USER'@'%' IDENTIFIED BY '$WP_ADMIN_PASSWORD';
	GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_ADMIN_USER'@'%';
	FLUSH PRIVILEGES;
EOF

exec mariadbd --user=mysql