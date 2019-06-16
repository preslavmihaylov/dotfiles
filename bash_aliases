
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

# make prompt appear above cursor
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m'

PROMPT_COMMAND+='echo -e "${GREEN}$(whoami)@$(hostname)${NC}:${BLUE}$(dirs)${NC}"'
PS1='$ '

if [[ ! $TERM =~ screen ]]; then
    exec tmux
fi

