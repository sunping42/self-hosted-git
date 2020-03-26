#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <repository-name>"
    exit 1
fi

REPO_NAME=$1
REPO_PATH="/var/git/${REPO_NAME}.git"

if [ -d "$REPO_PATH" ]; then
    echo "Repository $REPO_NAME already exists"
    exit 1
fi

sudo -u git mkdir -p "$REPO_PATH"
cd "$REPO_PATH"
sudo -u git git init --bare
sudo -u git git config http.receivepack true

echo "Repository $REPO_NAME created at $REPO_PATH"
