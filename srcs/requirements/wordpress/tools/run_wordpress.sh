#!/bin/bash

# Setup wp https://make.wordpress.org/cli/handbook/guides/installing/
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

echo -e "\n\n"

WP_ADMIN_PASSWORD=$(cat $DB_ADMIN_PASSWORD_FILE)

until mysqladmin ping \
  -h"$DB_HOST" \
  -u"$DB_ADMIN_USER" \
  -p"$WP_ADMIN_PASSWORD" \
  --silent; do
    echo "Waiting for db to start up..."
    sleep 1
done

chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp --info

cd /var/www/html

rm -rf *

# Download wp https://developer.wordpress.org/cli/commands/core/download/
wp core download --locale=en_US --allow-root

# Replace wp-config-sample.php with wp-config.php and fill in credentials
sed \
	-e "s/database_name_here/$DB_NAME/" \
	-e "s/username_here/$DB_ADMIN_USER/" \
	-e "s/password_here/$WP_ADMIN_PASSWORD/" \
	-e "s/localhost/$DB_HOST/" \
	wp-config-sample.php > wp-config.php

# Temp fix for browser redirect to localhost:443
echo "define('WP_HOME', 'https://localhost:1443'); \
define('WP_SITEURL', 'https://localhost:1443');" >> wp-config.php

# Install wp https://developer.wordpress.org/cli/commands/core/install/
wp core install \
	--url=$WP_URL \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--allow-root

WP_DB_USER1_PASSWORD=$(cat $WP_DB_USER1_PASSWORD_FILE)

# Create second user https://developer.wordpress.org/cli/commands/user/create/
wp user get $WP_DB_USER1 --allow-root &>/dev/null || \
wp user create \
	$WP_DB_USER1 \
	$WP_DB_USER1_EMAIL \
	--user_pass=$WP_DB_USER1_PASSWORD \
	--role=author \
	--allow-root



# configure php-fpm to listen to 9000 to communicate with nginx
sed -i "s#listen = /run/php/php8.2-fpm.sock#listen = 0.0.0.0:9000#" /etc/php/8.2/fpm/pool.d/www.conf

# dpkg -L php-fpm
# which php-fpm
echo "Setup done: starting php-fpm"

/usr/sbin/php-fpm8.2 -F