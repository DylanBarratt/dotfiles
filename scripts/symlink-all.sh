#!/bin/bash

# ln -sf /path/to/file /path/to/symlink

# .config
ln -sf ~/.dotfiles/config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/config/git ~/.config/git

# .home
ln -sf ~/.dotfiles/dot/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/dot/.zshrc ~/.zshrc

if [ $WSL_DISTRO_NAME = "Ubuntu" ] 
then
  echo "setting up symlink for WSL"
  # ln -sf ~/.dotfiles/dot/.wezterm.lua /mnt/c/Users/barrad/
else
  echo "setting up symlink for native linux"
  ln -sf ~/.dotfiles/dot/.wezterm.lua ~/.wezterm.lua
fi
