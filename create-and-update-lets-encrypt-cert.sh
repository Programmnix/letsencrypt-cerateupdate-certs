#!/bin/bash

domain=$1
email=$2
TMP_DIR=/tmp/create_certs
LETS_ENCRYPT_DIR=/etc/letsencrypt
LIVE_LETS_ENCRYPT_DIR=$LETS_ENCRYPT_DIR/live

NGINX_CERTS_DIR=/etc/nginx/certs

function main {
	if [ "$domain" == "" ]; then
	        echo "ERROR: Usage: ./create-and-update-lets-encrypt-cert.sh www.example.tdl max.mustermann@example.com"
	        exit 1
	fi

	mkdir -p $TMP_DIR
	cd $TMP_DIR
	wget https://dl.eff.org/certbot-auto
	chmod a+x certbot-auto

	/etc/init.d/nginx stop
	/etc/init.d/nginx status

	if [ -d "$LIVE_LETS_ENCRYPT_DIR/$domain" ]; then
		renew_certificate
	
	else
		create_certificate
	fi

	exit 0
}

function create_certificate {
	./certbot-auto certonly --standalone -n --agree-tos -d $domain --email $email 
	deploy_certs $domain
	clean_up
}

function renew_certificate {
	./certbot-auto renew 
	deploy_certs $domain
	clean_up
}

function clean_up {
	rm -rf $TMP_DIR
}

function deploy_certs {
	domain=$1
	mkdir -p $NGINX_CERTS_DIR
	cp -f $LIVE_LETS_ENCRYPT_DIR/$domain/fullchain.pem $NGINX_CERTS_DIR/$domain.crt
	cp -f $LIVE_LETS_ENCRYPT_DIR/$domain/privkey.pem $NGINX_CERTS_DIR/$domain.key
}

main
exit 0
