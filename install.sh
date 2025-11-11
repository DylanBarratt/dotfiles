#!/bin/bash

installMsg() {
  echo "--------------------------------"
  echo "INSTALLING $1"
  echo "--------------------------------"
}

# INSTALL STUFF!
(
  installMsg "STUFF"
  # move to tmp so any setup files installed are not in the way
  cd /tmp

  apt update

  # fd find
  installMsg "fd"
  apt install -y fd-find

  # zsh
  installMsg "zsh"
  apt install -y zsh
  chsh -s $(which zsh) # change default shell to zsh

  # Lua:
  installMsg "lua"
  (
    apt-get install -y libreadline-dev
    curl -L -R -O https://www.lua.org/ftp/lua-5.1.tar.gz
    tar zxf lua-5.1.tar.gz
    cd lua-5.1
    make linux
    make all test
    make all install
  )

  # luarocks
  installMsg "luarocks"
  (
    wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
    tar zxpf luarocks-3.11.1.tar.gz
    cd luarocks-3.11.1
    ./configure && make && sudo make install
    luarocks install luasocket
    lua
  )

  # fzf
  installMsg "fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
)

# TODO:
#      install:
#       zsh plugins

mkdir ~/.config
cp -r ./nvim ~/.config

cp ./.zshrc ~/.zshrc

cp ./.p10k.zsh ~/.p10k.zsh
