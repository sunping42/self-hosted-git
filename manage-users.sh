#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <add|remove> <username> [ssh-key-file]"
    exit 1
fi

ACTION=$1
USERNAME=$2
SSH_KEY_FILE=$3

case $ACTION in
    add)
        if [ -z "$SSH_KEY_FILE" ]; then
            echo "SSH key file required for adding user"
            exit 1
        fi
        
        if [ ! -f "$SSH_KEY_FILE" ]; then
            echo "SSH key file not found: $SSH_KEY_FILE"
            exit 1
        fi
        
        sudo -u git mkdir -p /home/git/.ssh
        echo "# $USERNAME" | sudo -u git tee -a /home/git/.ssh/authorized_keys
        cat "$SSH_KEY_FILE" | sudo -u git tee -a /home/git/.ssh/authorized_keys
        sudo -u git chmod 600 /home/git/.ssh/authorized_keys
        echo "User $USERNAME added"
        ;;
        
    remove)
        sudo -u git sed -i "/# $USERNAME/,+1d" /home/git/.ssh/authorized_keys
        echo "User $USERNAME removed"
        ;;
        
    *)
        echo "Invalid action: $ACTION"
        exit 1
        ;;
esac
