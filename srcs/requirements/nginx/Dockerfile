# syntax=docker/dockerfile:1

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/run_nginx.sh /etc/nginx/run_nginx.sh

RUN chmod +x /etc/nginx/run_nginx.sh

EXPOSE 1443

CMD ["/etc/nginx/run_nginx.sh"]