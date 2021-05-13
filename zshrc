export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [ -f ~/.bash_common ]; then
    source ~/.bash_common
fi

ZSH_DISABLE_COMPFIX=true
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

export TERM="xterm-256color"

export JAVA_HOME=$(/usr/libexec/java_home)

# added for node
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi
