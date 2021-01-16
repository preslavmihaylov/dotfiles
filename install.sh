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

# alacritty install (sensible for mac only)
if [ $ARCH = 'Darwin' ]; then
    cp -r $MYDIR/alacritty ~/.config/alacritty
fi

# .bash_aliases install
cp $MYDIR/bash_aliases ~/.bash_aliases
if [ -f ~/.zshrc ]; then
    echo "[ -f ~/.bash_aliases ] && source ~/.bash_aliases" >> ~/.zshrc
fi

# tmux conf install
cp $MYDIR/tmux.conf ~/.tmux.conf
cp -r $MYDIR/tmux-gitbar ~/.tmux-gitbar

# Install coc extensions
vim -c 'CocInstall -sync coc-json coc-html coc-css coc-tsserver coc-prettier coc-go|q'

echo "dotfiles finished installing!"
