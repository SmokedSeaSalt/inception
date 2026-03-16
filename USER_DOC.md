# This document is for users.

## What services are running

Inceptions runs wordpress using php-fpm using a mariaDB database to store user data. It uses nginx as the webserver.

## How to start and stop the server

The terminal command ```make start``` will start the webserver.
The terminal command ```make stop``` will stop the webserver.
The terminal command ```make clean``` will cleanup and delete all volumes.

## How to access the website and Wordpress Admin panel

The website is hosted locally at https://mvan-rij.42.fr. To access the admin panel navigate to https://mvan-rij.42.fr/wp-admin and login using the admin credentials.

## Where are credentials stored and how to change them

The public credentials are stored in the .env file. The passwords are stored in the secrets folder.

## How to check that services are running correctly

```docker ps``` can be used to check the status of the containers.
