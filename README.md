# dotfiles

A collection of dotfiles I use for my standard linux installations.

The dotfiles include:
* vim config and vim plugins
* tmux configuration
* custom bash aliases and options
* the bash scripts I use and have added to PATH

## Dependencies
I usually use this as a supplemental repository to my [default-setups](https://github.com/preslavmihaylov/default-setups) repo.  
In it, you will find a script for installing all the software I use on my Ubuntu machines.  
Some of the features here might not work properly without the tools installed from the other repo.

These are the tools you will need to, surely, install:
* tmux
* neovim
* cmake
* ctags
* cscope
* build-essential
* python3
* python
* npm
* nodejs
* go

All of these can be installed using the `apt-get install` utility. If you would like to find the exact commands, check out [default-setups](https://github.com/preslavmihaylov/default-setups)

If you found out I missed a dependency, feel free to submit a PR. :)

## Installation

```
git clone https://github.com/preslavmihaylov/dotfiles
cd dotfiles 
git submodule update --init --recursive
./install.sh
```

## Customizing some options
These configurations include options, which I use and have found useful.  
You might not find all of them useful for yourself.

However, I've written the configurations/scripts with a lot of comments, enabling you to customize them
suited to your needs.

The next section can help you find where things are.

## Contents
### vim plugins
All plugins are located in vim/bundle as submodules.  
If you would like to remove some of the plugins found there, modify `.gitmodules` and remove the relevant section

Also, the `YouCompleteMe` vim plugin can optionally include code completion support for some languages.  
Currently, I've enabled extra support for `go`, `javascript/ts`, `c/c++`.  
If you would like to exclude some of these, modify the `install_ycm.sh` file.  
If you want to add some extra code completion support (csharp, java, rust), refer to the [YouCompleteMe Documentaion](https://github.com/Valloric/YouCompleteMe#linux-64-bit)

### vim options
I have separated my vim configurations into several .vim files:
 * vim/config.vim - general configuration for vim
 * vim/plugins.vim - custom configurations for all my plugins
 * vim/mappings.vim - custom vim mappings
 * vim/commands.vim - custom commands I've created. **Beware**, These are used in other config files as well.

### tmux configuration
Located in `tmux.conf`

### Bash options
Located in `bash_aliases`. This is the default user bash profile configuration used on Ubuntu.  
This might differ if you are using a different Linux distribution.

If that is the case, adding this line to your .bashrc should fix it:
```
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```
