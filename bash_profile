if [ "$(uname)" == "Darwin" ]; then
    [ -f ~/.bash_common ] && source ~/.bash_common
    [ -f ~/.bash_local ] && source ~/.bash_local
    bind -f ~/.inputrc

    export PATH=$HOME/bin:/usr/local/bin:$PATH

    export PS1="$BIBlue$PathShort$Color_Off\$ "
    export TERM="xterm-256color"
    export BASH_SILENCE_DEPRECATION_WARNING=1

    eval "$(/opt/homebrew/bin/brew shellenv)"
    [ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion

    alias 'vi'='~/.dotfiles/nvim/vimr'

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    source "$HOME/.bashrc"

fi

_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh
