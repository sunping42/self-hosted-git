#!/bin/bash

apt-get update
apt-get install -y git nginx

adduser --system --group --shell /bin/bash git
mkdir -p /var/git
chown git:git /var/git

su - git -c "git config --global user.name 'Git Server'"
su - git -c "git config --global user.email 'git@server.local'"
