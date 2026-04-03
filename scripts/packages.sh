#!/bin/bash

# installs system (linux) agnostic packages

installMsg() {
  echo "--------------------------------"
  echo "INSTALLING $1"
  echo "--------------------------------"
}

# INSTALL STUFF!
(
  installMsg "STUFF"

  # store programs
  mkdir -p ~/programs

  # store executables
  mkdir -p ~/bin

  # move to tmp so any setup files installed can be discarded
  cd /tmp
  mkdir -p install-tmp
  cd install-tmp

  # nvim
  installMsg "nvim"
  (
    curl -LO https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz
    rm -rf ~/programs/nvim-linux-x86_64
    tar -C ~/programs -xzf nvim-linux-x86_64.tar.gz
  )

  installMsg "nvim:extras"
  (
    curl -LO https://github.com/aws-cloudformation/cloudformation-languageserver/releases/download/v1.4.0/cloudformation-languageserver-1.4.0-linux-x64-node22.zip
    rm -rf ~/bin/cfn_ls
    unzip cloudformation-languageserver-1.4.0-linux-x64-node22.zip -d ~/bin/cfn_ls
  )

  # lua
  installMsg "lua"
  (
    # needs libreadline-dev
    # e.g. apt-get install -y libreadline-dev
    curl -L -R -O https://www.lua.org/ftp/lua-5.1.tar.gz
    tar zxf lua-5.1.tar.gz
    cd lua-5.1
    make linux
    sudo make all install
  )

  # luarocks
  installMsg "luarocks"
  (
    curl -L -O https://luarocks.org/releases/luarocks-3.11.1.tar.gz
    tar zxpf luarocks-3.11.1.tar.gz
    cd luarocks-3.11.1
    sudo ./configure
    sudo make
    sudo make install
    sudo luarocks install luasocket
  )

  # fzf
  installMsg "fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --no-key-bindings --completion --update-rc

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

  rm -rf install-tmp
)
