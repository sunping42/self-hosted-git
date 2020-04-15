#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <repository-name>"
    exit 1
fi

REPO_NAME=$1
REPO_PATH="/var/git/${REPO_NAME}.git"

if [ ! -d "$REPO_PATH" ]; then
    echo "Repository $REPO_NAME does not exist"
    exit 1
fi

echo "Are you sure you want to delete repository $REPO_NAME? (y/N)"
read -r response

if [[ "$response" =~ ^[Yy]$ ]]; then
    rm -rf "$REPO_PATH"
    echo "Repository $REPO_NAME deleted"
else
    echo "Operation cancelled"
fi
