# Stuffs to setup

## Neovim

## Zsh

## lua 5.1
``` sh
# dependencies
sudo apt-get install libreadline-dev 

curl -L -R -O https://www.lua.org/ftp/lua-5.1.tar.gz
tar zxf lua-5.1.tar.gz
cd lua-5.1
make linux
make all test
sudo make all install
```

## luarocks
*needs lua*
```sh
wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
tar zxpf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1
./configure && make && sudo make install
sudo luarocks install luasocket
lua
```

## television
``` sh
curl -LO https://github.com/alexpasmantier/television/releases/download/0.7.0/television_0.7.0-1_amd64.deb
sudo dpkg -i television_0.7.0-1_amd64.deb
```
