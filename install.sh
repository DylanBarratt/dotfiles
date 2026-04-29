#!/bin/bash

# installs zsh, neovim, and needed extras for my setup
# BINARIES: /usr/local/bin
# COMPLETION: /etc/bash_completion.d
# PROGRAMS: /opt

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

  # rq
  installMsg "ripgrep"
  (
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz
    tar -xzf ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz
    cp ripgrep-15.1.0-x86_64-unknown-linux-musl/rg /usr/local/bin
    cp ripgrep-15.1.0-x86_64-unknown-linux-musl/complete/rg.bash /etc/bash_completion.d
  )

  # nvim
  installMsg "nvim"
  (
    curl -LO https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz
    rm -rf /opt/nvim-linux-x86_64
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  )

  installMsg "nvim:extras"
  (
    curl -LO https://github.com/aws-cloudformation/cloudformation-languageserver/releases/download/v1.4.0/cloudformation-languageserver-1.4.0-linux-x64-node22.zip
    unzip cloudformation-languageserver-1.4.0-linux-x64-node22.zip -d /usr/local/bin/cfn_ls
    # WARNING: assumes npm is installed!
    npm install --global tree-sitter-cli
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
    ./configure && make && make install
    luarocks install luasocket
  )

  # fzf
  installMsg "fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --no-key-bindings --completion --update-rc

  # gum
  mkdir -p /etc/apt/keyrings
  curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list
  apt update && apt install gum

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

./scripts/link-configs.sh

# copy devcontainer workspace(s) to home in worktree format i like :)
if [ -d "/workspaces" ]; then
  cd /workspaces || return
  for folder in $(echo */); do
    echo "duplicating $folder"
    mkdir "$HOME/$folder"
    cp -r "/workspaces/$folder" "$HOME/$folder/master"
  done
fi
