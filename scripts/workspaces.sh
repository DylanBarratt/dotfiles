#!/bin/bash

# copy devcontainer workspace(s) to home in worktree format i like :)
if [ -d "/workspaces" ]; then
  cd /workspaces || return
  for folder in $(echo */); do
    echo "duplicating $folder"
    mkdir "$HOME/$folder"
    cp -r "/workspaces/$folder" "$HOME/$folder/master"
  done
fi
