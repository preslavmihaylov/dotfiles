#!/bin/bash

sudo apt remove vim vim-runtime gvim
sudo apt install lua5.1 lua5.1-dev libperl-dev libncurses5-dev

cd /tmp
git clone https://github.com/vim/vim.git
cd vim

./configure --with-features=huge \
            --enable-rubyinterp=yes \
            --enable-largefile  \
            --enable-pythoninterp=yes \
            --with-python-config-dir=$(python-config --configdir) \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --enable-multibyte \
            --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
#sudo checkinstall
sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim

cd ~
sudo rm -rf /tmp/vim
