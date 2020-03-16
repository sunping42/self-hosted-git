#!/bin/bash

apt-get update
apt-get install -y git nginx fcgiwrap

adduser --system --group --shell /bin/bash git
mkdir -p /var/git
chown git:git /var/git

su - git -c "git config --global user.name 'Git Server'"
su - git -c "git config --global user.email 'git@server.local'"

cp nginx-git.conf /etc/nginx/sites-available/git
ln -sf /etc/nginx/sites-available/git /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

systemctl enable fcgiwrap
systemctl start fcgiwrap
systemctl reload nginx
