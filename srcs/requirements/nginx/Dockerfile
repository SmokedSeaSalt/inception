# syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY secrets/inception.crt /etc/nginx/inception.crt
COPY secrets/inception.key /etc/nginx/inception.key
COPY index.html /var/www/html/index.html

EXPOSE 1443

CMD ["nginx", "-g", "daemon off;"]