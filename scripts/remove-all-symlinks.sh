#!/bin/sh

# .config
unlink ~/.config/nvim
unlink ~/.config/git
unlink ~/.config/television

# .home
unlink ~/.tmux.conf
unlink ~/.zshrc
unlink ~/.p10k.zsh
unlink ~/dict.txt

if [ "$WSL_DISTRO_NAME" = "Ubuntu" ];
then
  echo "removing symlink for WSL"
  # unlink ~/.wezterm.lua
else
  echo "removing symlink for native linux"
  unlink ~/.wezterm.lua
fi
