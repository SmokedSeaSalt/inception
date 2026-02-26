#!/bin/bash

mkdir -p /run/mysqld

chown -R mysql:mysql /run/mysqld

# Listen to all ports to be able to receive wordpress requests
echo "bind-address=0.0.0.0" >> /etc/mysql/mariadb.conf.d/50-server.cnf

WP_ADMIN_PASSWORD=$(cat $DB_ADMIN_PASSWORD_FILE)
WP_ROOT_PASSWORD=$(cat $DB_ROOT_PASSWORD_FILE)

# Start MariaDB temporarily
mariadbd --user=mysql --skip-networking & pid="$!"


# Wait until server is ready
MAX_TRIES=30
TRIES=0
until mysqladmin ping --silent; do
    TRIES=$((TRIES + 1))

    if [ "$TRIES" -ge "$MAX_TRIES" ]; then
        echo "MariaDB did not become ready after $MAX_TRIES attempts"
        exit 1
    fi

    echo "Waiting for MariaDB... ($TRIES/$MAX_TRIES tries)"
    sleep 1
done

# Configure database and users
mysql <<EOF
	USE mysql;

	CREATE DATABASE IF NOT EXISTS $DB_NAME;

	CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '$WP_ROOT_PASSWORD';
	CREATE USER IF NOT EXISTS 'root'@'127.0.0.1' IDENTIFIED BY '$WP_ROOT_PASSWORD';
	CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$WP_ROOT_PASSWORD';

	ALTER USER 'root'@'localhost' IDENTIFIED BY '$WP_ROOT_PASSWORD';
	ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY '$WP_ROOT_PASSWORD';
	ALTER USER 'root'@'%' IDENTIFIED BY '$WP_ROOT_PASSWORD';
	FLUSH PRIVILEGES;

	CREATE USER IF NOT EXISTS 'health'@'%' IDENTIFIED BY 'healthpass';
	GRANT USAGE ON *.* TO 'health'@'%';
	FLUSH PRIVILEGES;

	CREATE USER IF NOT EXISTS '$DB_ADMIN_USER'@'%' IDENTIFIED BY '$WP_ADMIN_PASSWORD';
	GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_ADMIN_USER'@'%';
	FLUSH PRIVILEGES;
EOF

# Stop temperary MariaDB process
mysqladmin -uroot -p"${WP_ROOT_PASSWORD}" shutdown

wait "$pid"

# Start actual MariaDB process to be used in docker network
exec mariadbd --user=mysql