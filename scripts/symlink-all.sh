#!/bin/bash

# ln -sf /path/to/file /path/to/symlink

# .config
ln -sf ~/.dotfiles/config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/config/git ~/.config/git

# .home
ln -sf ~/.dotfiles/dot/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/dot/.wezterm.lua ~/.wezterm.lua
ln -sf ~/.dotfiles/dot/.zshrc ~/.zshrc
