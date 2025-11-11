#!/bin/bash

# INSTALL STUFF!
(
  # move to tmp so any setup files installed are not in the way
  cd /tmp

  apt update

  # fd find
  apt install fd-find

  # zsh
  apt install zsh
  chsh -s $(which zsh) # change default shell to zsh

  # Lua:
  (
    apt-get install libreadline-dev
    curl -L -R -O https://www.lua.org/ftp/lua-5.1.tar.gz
    tar zxf lua-5.1.tar.gz
    cd lua-5.1
    make linux
    make all test
    make all install
  )

  # luarocks
  (
    wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
    tar zxpf luarocks-3.11.1.tar.gz
    cd luarocks-3.11.1
    ./configure && make && sudo make install
    luarocks install luasocket
    lua
  )

  # fzf
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
