#!/bin/bash

BACKUP_DIR="/var/backups/git"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="git_backup_$DATE.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "Starting backup..."
tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C /var git

if [ $? -eq 0 ]; then
    echo "Backup completed: $BACKUP_DIR/$BACKUP_FILE"
    
    find "$BACKUP_DIR" -name "git_backup_*.tar.gz" -mtime +7 -delete
    echo "Old backups cleaned up"
else
    echo "Backup failed"
    exit 1
fi
