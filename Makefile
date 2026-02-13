#prerequisites
# openssl -> apt-get install openssl

################################################################################
# Basics                                                                       #
################################################################################


SSL_KEY = secrets/inception.key
SSL_CRT = secrets/inception.crt

all:
	docker-compose -f srcs/docker-compose.yml up --build



generate_key: | $(SSL_CRT)
	openssl genrsa -aes256 -passout pass:inception -out secrets/inception.pass.key 4096
	openssl rsa -passin pass:inception -in secrets/inception.pass.key -out secrets/inception.key
#	rm server.pass.key #optional
	openssl req -new -key secrets/inception.key -out secrets/inception.csr -subj "/C=NL/ST=North-Holland/L=Amsterdam/O=Codam/CN=inception"
	openssl x509 -req -sha256 -days 365 -in secrets/inception.csr -signkey secrets/inception.key -out secrets/inception.crt