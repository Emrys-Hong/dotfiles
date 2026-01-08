if [ "$(uname)" == "Darwin" ]; then
    [ -f ~/.bash_common ] && source ~/.bash_common
    bind -f ~/.inputrc
    export PATH=$HOME/bin:/usr/local/bin:$PATH

    export PS1="$BIBlue$PathShort$Color_Off\$ "
    export TERM="xterm-256color"
    export BASH_SILENCE_DEPRECATION_WARNING=1

    eval "$(/opt/homebrew/bin/brew shellenv)"
    [ -f $(brew --prefix)/etc/bash_completion ] && . $(brew --prefix)/etc/bash_completion

   alias 'vi'='code'
   alias 'vim'='/Applications/MacVim.app/Contents/MacOS/Vim -g -u ~/.dotfiles/nvim/minimal.vim'

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    source "$HOME/.bashrc"

fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

