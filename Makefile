#prerequisites
# openssl -> apt-get install openssl

################################################################################
# General                                                                      #
################################################################################

all: up

re: down all


################################################################################
# Docker                                                                       #
################################################################################


up:
	docker-compose -p inception -f srcs/docker-compose.yml up --build

down:
	docker-compose -p inception -f srcs/docker-compose.yml down -v


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