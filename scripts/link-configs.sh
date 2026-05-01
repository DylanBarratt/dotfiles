#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

mkdir -p ~/.config

rm -rf ~/.config/nvim
ln -s "$DOTFILES_DIR/nvim" ~/.config/nvim

rm -f ~/.zshrc
ln -s "$DOTFILES_DIR/.zshrc" ~/.zshrc

rm -f ~/.p10k.zsh
ln -s "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

rm -f ~/.config/gitCommands
ln -s "$DOTFILES_DIR/gitCommands" ~/.config/gitCommands

rm -f ~/.wezterm.lua
ln -s "$DOTFILES_DIR/.wezterm.lua" ~/.wezterm.lua

rm -f ~/.kiro/skills
ln -s "$DOTFILES_DIR/kiro/skills" ~/.kiro/skills

rm -f ~/.kiro/steering
ln -s "$DOTFILES_DIR/kiro/steering" ~/.kiro/steering
