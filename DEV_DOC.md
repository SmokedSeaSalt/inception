# This document is for administrators.

## Setup the correct environment

### Prerequisits

This project requires docker and docker compose to be installed.

### Configuration files

A .env_example is provided for the administrator to setup a desired .env.

### Secrets

The secrets should be in the srcs/secrets directory.
The needed secrets for the current configuration are:
- srcs/secrets/db_admin_password.txt
- srcs/secrets/db_default_user_password.txt
- srcs/secrets/db_root_password.txt
- srcs/secrets/db_user1_password.txt

## Build and launch the server.

1. git clone this repository.
2. cd into the cloned directory.
3. check [Configuration files](#configuration-files) and [Secrets](#secrets) to setup the environment correctly.
4. ```make```.

## Usefull commands

## Data storage





DEV_DOC.md — Developer documentation This file must describe how a developer can:
◦ Set up the environment from scratch (prerequisites, configuration files, secrets).
◦ Build and launch the project using the Makefile and Docker Compose.
◦ Use relevant commands to manage the containers and volumes.
◦ Identify where the project data is stored and how it persists.