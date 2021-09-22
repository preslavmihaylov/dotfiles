#!/bin/bash

# make sure directory path is ok when script is started from anywhere
MYDIR="$(dirname -- "$0")"

# .vimrc install
cp $MYDIR/vimrc ~/.vimrc

# .vim install
rm -rf ~/.vim || true
cp -r $MYDIR/vim ~/.vim

mkdir -p ~/.config

# nvim install
rm -rf ~/.config/nvim || true
cp -r $MYDIR/nvim ~/.config/nvim

# alacritty install (sensible for mac only)
if [ $ARCH = 'Darwin' ]; then
    cp -r $MYDIR/alacritty ~/.config/alacritty
fi

# .bash_aliases install
cp $MYDIR/bash_aliases ~/.bash_aliases

# apply bash aliases for zsh as well
echo "[ -f ~/.bash_aliases ] && source ~/.bash_aliases" >> ~/.zshrc

# tmux conf install
cp $MYDIR/tmux.conf ~/.tmux.conf
cp -r $MYDIR/gitmux.conf ~/.gitmux.conf

# Install coc extensions
vim -c 'CocInstall -sync coc-json coc-html coc-css coc-tsserver coc-prettier coc-go coc-styled-components coc-graphql' +qall
vim -c 'GoInstallBinaries' +qall

echo "dotfiles finished installing!"
