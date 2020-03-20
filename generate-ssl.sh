#!/bin/bash

DOMAIN=${1:-git.example.com}
CERT_DIR="/etc/ssl"

if [ ! -d "$CERT_DIR/private" ]; then
    mkdir -p "$CERT_DIR/private"
fi

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$CERT_DIR/private/git.key" \
    -out "$CERT_DIR/certs/git.crt" \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=$DOMAIN"

chmod 600 "$CERT_DIR/private/git.key"
chmod 644 "$CERT_DIR/certs/git.crt"

echo "SSL certificate generated for $DOMAIN"
