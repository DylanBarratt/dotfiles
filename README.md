# Stuffs to setup

## Gum

Needed for git scripts

```sh
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install gum
```

## Neovim

https://neovim.io

### lua 5.1

```sh
# dependencies
sudo apt-get install libreadline-dev 

curl -L -R -O https://www.lua.org/ftp/lua-5.1.tar.gz
tar zxf lua-5.1.tar.gz
cd lua-5.1
make linux
make all test
sudo make all install
```

### luarocks

*needs lua*

```sh
wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
tar zxpf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1
./configure && make && sudo make install
sudo luarocks install luasocket
lua
```

### eslint

```sh
npm install -G eslint typescript-eslint
```

## Zsh

https://ohmyz.sh

Theme: https://github.com/romkatv/powerlevel10k
