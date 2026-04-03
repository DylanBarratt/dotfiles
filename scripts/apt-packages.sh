#!/bin/bash

# installs zsh, neovim, and needed extras for my setup

installMsg() {
  echo "--------------------------------"
  echo "INSTALLING $1"
  echo "--------------------------------"
}

# INSTALL STUFF!
(
  installMsg "STUFF"
  # move to tmp so any setup files installed can be discarded
  cd /tmp

  apt update -y

  # basics
  apt install -y build-essential libreadline-dev zip unzip wget curl

  # fd find
  installMsg "fd"
  apt install -y fd-find

  # zsh
  installMsg "zsh"
  apt install -y zsh
  chsh -s "$(which zsh)" # change default shell to zsh

  # lua dep
  installMsg "lua dep"
  apt-get install -y libreadline-dev

  # delta
  installMsg "delta"
  (
    curl -LO https://github.com/dandavison/delta/releases/download/0.18.0/git-delta_0.18.0_amd64.deb
    dpkg --install ./git-delta_0.18.0_amd64.deb
    git config --global core.pager delta
    git config --global interactive.diffFilter 'delta --color-only'
    git config --global delta.navigate true
    git config --global delta.light true
    git config --global delta.line-numbers true
    git config --global merge.conflictStyle zdiff3
  )

  # gum
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list
  apt update && apt install gum
)
