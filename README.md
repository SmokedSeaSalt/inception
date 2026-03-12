This project has been created as part of the 42 curriculum by mvan-rij.

## Description
This project aims to broaden the knowledge of system administration by using Docker.
It teaches to virtualize several Docker images, creating them in a new personal virtual
machine.

### Virtual Machines vs Docker

#### Virtual Machines (VMs)
A **Virtual Machine (VM)** is a full emulation of a physical computer. It runs an entire operating system (OS) on top of a hypervisor, which allocates resources like CPU, memory, and storage. VMs are isolated from the host system, and each VM has its own kernel.

#### Docker
**Docker** is a platform for building, shipping, and running applications inside containers. Containers are lightweight, isolated environments that share the host system’s kernel but operate independently.

#### Comparison:
- **VMs**: Full OS, heavy on resources, complete isolation.
- **Docker**: Lightweight, shares the host OS kernel, ideal for microservices and scalable apps.

---

### Secrets vs Environment Variables

#### Secrets
**Secrets** are sensitive data (like passwords, API keys, or certificates) that should be stored securely and not exposed in your source code. In Docker, secrets are typically managed using Docker Secrets, which are encrypted and can only be accessed by specific services.

#### Environment Variables
**Environment Variables** are a way to store configuration or sensitive information in a key-value pair format. They are typically used to pass variables into containers or applications and can be set either during container creation or within the Dockerfile.

#### Comparison:
- **Secrets**: Secure, encrypted storage for sensitive data.
- **Environment Variables**: Easily accessible but can be exposed if not managed securely.

---

### Docker Network vs Host Network

#### Docker Network
A **Docker Network** is a virtual network created by Docker that allows containers to communicate with each other. Docker provides multiple network modes, such as `bridge`, `overlay`, and `host`, to facilitate different network configurations.

#### Host Network
The **Host Network** mode allows a container to share the same network namespace as the host. In this mode, the container uses the host’s IP address, and network ports are directly mapped to the container.

#### Comparison:
- **Docker Network**: Offers isolation and flexibility, ideal for multi-container setups.
- **Host Network**: High performance, less isolation, and best for performance-critical applications.

---

### Docker Volumes vs Bind Mounts

#### Docker Volumes
**Volumes** are the preferred method for persisting data in Docker. Volumes are managed by Docker, stored in a specific location on the host system, and can be shared between containers. They are ideal for database storage or application data that needs to persist beyond container lifecycles.

#### Bind Mounts
**Bind Mounts** allow a file or directory from the host system to be mounted directly into a container. This provides more control over where the data is stored, and the container can modify the host files.

#### Comparison:
- **Volumes**: Managed by Docker, ideal for persistent storage and sharing data between containers.
- **Bind Mounts**: Directly mounts host directories into containers, more control but less portable.

## Instructions

## Recources

### Docker

[D1]  [Docker cmd cheatsheet](https://github.com/sidpalas/devops-directive-docker-course/blob/main/10-interacting-with-docker-objects/README.md)\
[D2]  [Docker volumes](https://docs.docker.com/engine/storage/volumes/)\
[D3]  [Docker secrets](https://docs.docker.com/compose/how-tos/use-secrets/)\
[D4]  [Dcoker networking](https://docs.docker.com/compose/how-tos/networking/)\
[D5]  [Startup order](https://docs.docker.com/compose/how-tos/startup-order/)\
[D6]  [Named volume at different host location](https://cravencode.com/post/docker/create-named-docker-bind-mount/)\
[D7]  [Running commands inside container](https://docs.docker.com/reference/cli/docker/container/exec/)\
[D8]  [Docker Volume VS Bind Mount](https://www.geeksforgeeks.org/devops/docker-volume-vs-bind-mount/)

### Nginx

[N1]  [Nginx example config](https://nginx.org/en/docs/http/configuring_https_servers.html)\
[N2]  [Nginx launch command](https://stackoverflow.com/questions/32661246/running-nginx-on-docker)\
[N3]  [Self-Signed SSL](https://devcenter.heroku.com/articles/ssl-certificate-self)\
[N4]  [SSL certificate settings](https://www.ibm.com/docs/en/ibm-mq/7.5.0?topic=certificates-distinguished-names)\
[N5]  [Nginx config for WP](https://tundedamian.medium.com/day-20-of-100-days-of-devops-deploying-a-php-application-with-nginx-and-php-fpm-ac9e0111d88a)

### MariaDB

[M1]  [MariaDB basics guide](https://mariadb.com/docs/server/mariadb-quickstart-guides/basics-guide)\
[M2]  [MariaDB Create users](https://utho.com/docs/database/mariadb/how-to-create-a-user-and-grantprevileges-on-a-specific-ip/)

### Wordpress

[W1]  [Install Worpress](https://make.wordpress.org/cli/handbook/guides/installing/)\
[W2]  [Manage WordPress installation](https://developer.wordpress.org/cli/commands/core/)\
[W3]  [Configuration the Listen Directive](https://serversforhackers.com/c/php-fpm-configuration-the-listen-directive)\
[W4]  [Downloader for wp-cli](https://developer.wordpress.org/cli/commands/core/download/)
[W5]  [Config settings](https://developer.wordpress.org/apis/wp-config-php/)
[W6]  [Create extra users](https://developer.wordpress.org/cli/commands/user/create/)