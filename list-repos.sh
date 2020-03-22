#!/bin/bash

echo "Git repositories on this server:"
echo "================================"

for repo in /var/git/*.git; do
    if [ -d "$repo" ]; then
        repo_name=$(basename "$repo" .git)
        echo "Repository: $repo_name"
        echo "  Path: $repo"
        
        if [ -f "$repo/description" ]; then
            desc=$(cat "$repo/description")
            if [ "$desc" != "Unnamed repository; edit this file 'description' to name the repository." ]; then
                echo "  Description: $desc"
            fi
        fi
        
        last_commit=$(sudo -u git git --git-dir="$repo" log -1 --format="%cd" --date=short 2>/dev/null)
        if [ ! -z "$last_commit" ]; then
            echo "  Last commit: $last_commit"
        fi
        
        echo ""
    fi
done
