#prerequisites
# openssl -> apt-get install openssl

################################################################################
# General                                                                      #
################################################################################

all: setup_volume up

re: clean all

.PHONY: all re setup_volume clean up start down stop copy_env copy_secrets generate_key

################################################################################
# Docker                                                                       #
################################################################################

setup_volume:
	mkdir -p /home/mvan-rij/data/WordPress /home/mvan-rij/data/DB

clean:
	docker compose -p inception -f srcs/docker-compose.yml down -v

delete_volumes:
	sudo rm -rf /home/mvan-rij/data/*
	
up:
	docker compose -p inception -f srcs/docker-compose.yml up --build

start: up

down:
	docker compose -p inception -f srcs/docker-compose.yml down

stop: down

################################################################################
# Local Env                                                                    #
################################################################################

copy_env:
	cp ~/Desktop/InceptionLocal/InceptionEnv ./srcs/.env

copy_secrets:
	mkdir ./srcs/secrets
	cp ~/Desktop/InceptionLocal/db_admin_password.txt ./srcs/secrets/db_admin_password.txt
	cp ~/Desktop/InceptionLocal/db_root_password.txt ./srcs/secrets/db_root_password.txt
	cp ~/Desktop/InceptionLocal/db_user1_password.txt ./srcs/secrets/db_user1_password.txt

################################################################################
# SSL                                                                          #
################################################################################

SSL_KEY_PASS = srcs/secrets/inception.pass.key
SSL_KEY = srcs/secrets/inception.key
SSL_CRT = srcs/secrets/inception.crt
SSL_SUBJ = "/C=NL/ST=North-Holland/L=Amsterdam/O=Codam/CN=inception"

generate_key: #| $(SSL_CRT)
	openssl genrsa -aes256 -passout pass:inception -out $(SSL_KEY_PASS) 4096
	openssl rsa -passin pass:inception -in $(SSL_KEY_PASS) -out $(SSL_KEY)
#	rm server.pass.key #optional
	openssl req -new -key $(SSL_KEY) -out srcs/secrets/inception.csr -subj $(SSL_SUBJ)
	openssl x509 -req -sha256 -days 365 -in srcs/secrets/inception.csr -signkey $(SSL_KEY) -out $(SSL_CRT)