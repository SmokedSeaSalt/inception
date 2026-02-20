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
	docker-compose -f srcs/docker-compose.yml up --build

down:
	docker-compose -f srcs/docker-compose.yml down -v


################################################################################
# SSL                                                                          #
################################################################################

SSL_KEY_PASS = secrets/inception.pass.key
SSL_KEY = secrets/inception.key
SSL_CRT = secrets/inception.crt
SSL_SUBJ = "/C=NL/ST=North-Holland/L=Amsterdam/O=Codam/CN=inception"

generate_key: | $(SSL_CRT)
	openssl genrsa -aes256 -passout pass:inception -out $(SSL_KEY_PASS) 4096
	openssl rsa -passin pass:inception -in $(SSL_KEY_PASS) -out $(SSL_KEY)
#	rm server.pass.key #optional
	openssl req -new -key $(SSL_KEY) -out secrets/inception.csr -subj $(SSL_SUBJ)
	openssl x509 -req -sha256 -days 365 -in secrets/inception.csr -signkey $(SSL_KEY) -out $(SSL_CRT)