# This document is for administrators.

## Setup the correct environment

### Prerequisits

This project requires docker and docker compose to be installed.

### Configuration files

A .env_example is provided for the administrator to setup a desired .env.
Make sure localhost(127.0.0.1) is rerouted to mvan-rij.42.fr by adding ```127.0.0.1	mvan-rij.42.fr``` to /etc/hosts.

### Secrets

The secrets should be in the srcs/secrets directory.
The needed secrets for the current configuration are:
- srcs/secrets/db_admin_password.txt
- srcs/secrets/db_default_user_password.txt
- srcs/secrets/db_root_password.txt
- srcs/secrets/wp_admin_password.txt
- srcs/secrets/wp_user1_password.txt

## Build and launch the server.

1. git clone this repository.
2. cd into the cloned directory.
3. check [Configuration files](#configuration-files) and [Secrets](#secrets) to setup the environment correctly.
4. ```make```.

## Usefull commands

### Docker

- [docker ps](https://docs.docker.com/reference/cli/docker/container/ls/)
- [docker network](https://docs.docker.com/reference/cli/docker/network/)
- [docker exec](https://docs.docker.com/reference/cli/docker/container/exec/)

### MariaDB

- use [database]
- SELECT * from wp_*; (add \G for formatting)

## Data storage

The docker volumes are stored at ~/mvan-rij/data.
To delete the database the command ```make delete_volumes``` can be used.
