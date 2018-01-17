#!/bin/bash

# make sure directory path is ok when script is started from anywhere
MYDIR="$(dirname -- "$0")"

# .vimrc install
cp $MYDIR/vimrc ~/.vimrc

# .vim install
rm -rf ~/.vim || true
cp -r $MYDIR/vim ~/.vim

# .bash_aliases install
cp $MYDIR/bash_aliases ~/.bash_aliases

# tmux conf install
cp $MYDIR/tmux.conf ~/.tmux.conf

# scripts install
rm -rf ~/scripts || true
cp -r $MYDIR/scripts ~/scripts
