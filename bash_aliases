
# disable terminal freeze when clicking Ctrl-s
stty -ixon

alias targz_extract="tar -xvf"
alias vi=vim
alias vim=nvim

# run gdb until program bombs & print stack trace
alias gdb_trace="gdb --batch --ex r --ex bt --ex q --args"

# Add all my scripts to path
PATH=$PATH:~/scripts

# make an environment variable for my cscope db
export CSCOPE_SRC=~/.cscope
export CSCOPE_EDITOR=vim

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

