
# disable terminal freeze when clicking Ctrl-s
stty -ixon

alias targz_extract="tar -xvf"
alias vi=vim
alias vim=nvim

# run gdb until program bombs & print stack trace
alias gdb_trace="gdb --batch --ex r --ex bt --ex q --args"

# Add all my scripts to path
PATH=$PATH:~/scripts

# Setup go environment
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:~/programming/go/bin
export GOPATH=$HOME/programming/go

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

