#!/bin/bash

# make sure directory path is ok when script is started from anywhere
MYDIR="$(dirname -- "$0")"

# .vimrc install
cp $MYDIR/vimrc ~/.vimrc

# .vim install
rm -rf ~/.vim || true
cp -r $MYDIR/vim ~/.vim

# nvim install
rm -rf ~/.config/nvim || true
cp -r $MYDIR/nvim ~/.config/nvim

# .bash_aliases install
cp $MYDIR/bash_aliases ~/.bash_aliases

# tmux conf install
cp $MYDIR/tmux.conf ~/.tmux.conf
cp -r $MYDIR/tmux-gitbar ~/.tmux-gitbar

# YCM plugin install
$MYDIR/install_ycm.sh

echo "dotfiles finished installing!"
