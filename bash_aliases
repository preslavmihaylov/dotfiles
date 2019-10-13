ARCH=$(uname -s)

# disable terminal freeze when clicking Ctrl-s
stty -ixon

export LC_ALL=en_US.UTF-8

alias targz_extract="tar -xvf"
alias vi=nvim
alias vim=nvim

if [ $ARCH = 'Darwin' ]; then
    alias chrome="open -a \"Google Chrome\""
fi

# run gdb until program bombs & print stack trace
alias gdb_trace="gdb --batch --ex r --ex bt --ex q --args"

# Add all my scripts to path
PATH=$PATH:~/scripts

# Run background scripts
for i in $(ls -d ~/scripts/.background/*); do
    bash $i &
done

# Setup go environment
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:~/programming/go/bin
export GOPATH=$HOME/programming/go

export FZF_DEFAULT_OPTS='
--color fg:252,bg:233,hl:#ff8787,fg+:252,bg+:235,hl+:#ff0000
--color info:144,prompt:161,spinner:135,pointer:135,marker:118'

# make prompt appear above cursor
HOST_CLR='\033[1;32m'

if [ $ARCH = 'Darwin' ]; then
    DIR_CLR='\033[1;38;5;208m'
else 
    DIR_CLR='\033[1;34m'
fi

NC='\033[0m'

PROMPT_COMMAND='echo -e "${HOST_CLR}$(whoami)@kingslanding${NC}:${DIR_CLR}$(dirs)${NC}"'
PS1='$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [[ ! $TERM =~ screen ]]; then
    tmux && exit
fi

