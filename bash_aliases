
# disable terminal freeze when clicking Ctrl-s
stty -ixon

# fixes locale related warnings on mac
export LC_ALL=en_US.UTF-8

alias targz_extract="tar -xvf"
alias vi=nvim
alias vim=nvim

# run gdb until program bombs & print stack trace
alias gdb_trace="gdb --batch --ex r --ex bt --ex q --args"

# Add all my scripts to path
PATH=$PATH:~/scripts

# Setup go environment
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:~/programming/go/bin
export GOPATH=$HOME/programming/go

# make prompt appear above cursor
HOST_CLR='\033[1;32m'
DIR_CLR='\033[1;34m' # use '\033[1;38;5;208m' for mac
NC='\033[0m'

PROMPT_COMMAND+='echo -e "${HOST_CLR}$(whoami)@$(hostname)${NC}:${DIR_CLR}$(dirs)${NC}"'
PS1='$ '

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

