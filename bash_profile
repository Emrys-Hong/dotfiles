if [ "$(uname)" == "Darwin" ]; then
    [ -f ~/.bash_common ] && source ~/.bash_common
    [ -f ~/.bash_local ] && source ~/.bash_local
    bind -f ~/.inputrc

    export PATH=$HOME/bin:/usr/local/bin:$PATH

    export PS1="$BIBlue$PathShort$Color_Off\$ "
    export TERM="xterm-256color"
    export BASH_SILENCE_DEPRECATION_WARNING=1

    [ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion

    alias 'vi'='/Applications/MacVim.app/Contents/MacOS/Vim -g -u ~/.dotfiles/nvim/minimal.vim'

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    source "$HOME/.bashrc"

fi
