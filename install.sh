#!/bin/bash

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

  apt update

  # basics
  apt install build-essential libreadline-dev unzip

  # fd find
  installMsg "fd"
  apt install -y fd-find

  # zsh
  installMsg "zsh"
  apt install -y zsh
  chsh -s "$(which zsh)" # change default shell to zsh

  # nvim
  installMsg "nvim"
  (
    curl -LO https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.tar.gz
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
    lua
  )

  # fzf
  installMsg "fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  # oh my zsh
  installMsg "oh my zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  # oh my zsh plugins
  installMsg "ohmyzsh plugins"
  # p10k
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
  # zsh-syntax-highlighting
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
  # zsh-vi-mode
  git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/plugins/zsh-vi-mode
)

mkdir ~/.config
rm -rf ~/.config/nvim
cp -r ./nvim ~/.config

rm -rf ~/.zshrc
cp ./.zshrc ~/.zshrc

rm -rf ~/.p10k.zsh
cp ./.p10k.zsh ~/.p10k.zsh
