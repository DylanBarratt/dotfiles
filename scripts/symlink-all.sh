#! /usr/bin/bash

# ln -sf /path/to/file /path/to/symlink
# sed -i -e 's/\r$//

# .config
ln -sf ~/.dotfiles/nvim ~/.config/
ln -sf ~/.dotfiles/git ~/.config/git

# .home
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.p10k.zsh ~/.p10k.zsh

if [ "$WSL_DISTRO_NAME" = "Ubuntu" ];
then
  echo "setting up symlink for WSL"
  # ln -sf ~/.dotfiles/dot/.wezterm.lua /mnt/c/Users/barrad/
else
  echo "setting up symlink for native linux"
  ln -sf ~/.dotfiles/.wezterm.lua ~/.wezterm.lua
fi
