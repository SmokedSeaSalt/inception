# syntax=docker/dockerfile:1

FROM debian:bookworm-slim


RUN apt-get update && apt-get install mariadb-server -y

COPY tools/run_mariadb.sh /etc/mariadb/run_mariadb.sh

RUN chmod +x /etc/mariadb/run_mariadb.sh


CMD ["/etc/mariadb/run_mariadb.sh"]