#!/bin/bash

# installs neovim and needed extras for my setup

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

  # nvim
  installMsg "nvim"
  (
    curl -LO https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz
    rm -rf /opt/nvim-linux-x86_64
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  )

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
  )

  # fzf
  installMsg "fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --no-key-bindings --completion --update-rc

)

mkdir ~/.config
rm -rf ~/.config/nvim
cp -r ./nvim ~/.config
