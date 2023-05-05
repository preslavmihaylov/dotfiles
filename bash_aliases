ARCH=$(uname -s)

# disable terminal freeze when clicking Ctrl-s
stty -ixon

export LC_ALL=en_US.UTF-8

# use non-black color for `null` values for the jq command
export JQ_COLORS="1;35:0;39:0;39:0;39:0;32:1;39:1;39"

alias targz_extract="tar -xvf"

# lite vim (no plugins or vimrc)
alias lvim="vim -u NONE"
alias vi=nvim
alias vim=nvim
alias v=vim
alias g=git

# go to root of repo
alias cdr='cd $(git rev-parse --show-toplevel)'

# change default editors for git & similar cli tools
export VISUAL=nvim
export EDITOR=nvim
export GIT_EDITOR=nvim

alias docker_rmi_all='docker rmi $(docker images -a -q)'
alias docker_stop_all='docker stop $(docker ps -a -q)'
alias docker_rm_all='docker rm $(docker ps -a -q)'

alias json_prettify="python -m json.tool"
alias loccntgo="loccnt \"*.go\" \"*_test.go\" \"mocks*\" \"vendor*\""
loccnt() {
    if [ -z $1 ]; then
        echo "Usage: ${FUNCNAME[0]} <included> <excluded>"
        return 
    fi

    excluded=""
    for i in "${@:2}"; do
        # old version, which doesn't work. This matches filename patterns only, but doesn't work for filepaths.
        # excluded="$excluded ! -iname \"$i\""
        excluded="$excluded ! -path \"$i\""
    done

    cmd="find . -type f \( -iname \"$1\" $excluded \) | xargs wc -l"
    eval "$cmd"
}

if [ $ARCH = 'Darwin' ]; then
    # use emacs key bindings for the terminal
    set -o emacs

    alias chrome="open -a \"Google Chrome\""

    # make macos use openssl for cpp compiles
    export LDFLAGS="-L/usr/local/opt/openssl/lib"
    export CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/include -L/usr/local/lib"
    export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

    precmd() { eval "$PROMPT_COMMAND" }
fi

# run gdb until program bombs & print stack trace
alias gdb_trace="gdb --batch --ex r --ex bt --ex q --args"

PATH=$PATH:/usr/local/go/bin
PATH=$PATH:~/scripts

# Go environment
PATH=$PATH:~/prg/go/bin
export GOPATH=$HOME/prg/go

export FZF_DEFAULT_OPTS='
--color fg:252,bg:233,hl:#ff8787,fg+:252,bg+:235,hl+:#ff0000
--color info:144,prompt:161,spinner:135,pointer:135,marker:118'

# make prompt appear above cursor
HOST_CLR='\033[1;49;92m'

# make prompt colorful
if [ $ARCH = 'Darwin' ]; then
    DIR_CLR='\033[1;38;5;208m'
else 
    DIR_CLR='\033[1;34m'
fi

NC='\033[0m'

PROMPT_COMMAND='echo -e "${HOST_CLR}$(whoami)@lannisport${NC}:${DIR_CLR}$(dirs)${NC}"'
PS1='$ '


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ ! $TERM =~ screen ]]; then
    tmux && exit
fi

