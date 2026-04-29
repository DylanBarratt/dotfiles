#!/bin/bash

mkdir -p ~/.config

rm -rf ~/.config/nvim
ln -s "$(realpath ../nvim)" "$(realpath ~/.config/nvim)"

rm -f ~/.zshrc
ln -s "$(realpath ../.zshrc)" "$(realpath ~/.zshrc)"

rm -f ~/.p10k.zsh
ln -s "$(realpath ../.p10k.zsh)" "$(realpath ~/.p10k.zsh)"

rm -f ~/.config/gitCommands
ln -s "$(realpath ../gitCommands)" "$(realpath ~/.config/gitCommands)"

rm -f ~/.wezterm.lua
ln -s "$(realpath ../.wezterm.lua)" "$(realpath ~/.wezterm.lua)"
