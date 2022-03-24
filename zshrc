[ -f ~/.bash_common ] && source ~/.bash_common
[ -f ~/.bash_local ] && source ~/.bash_local

ZSH_DISABLE_COMPFIX=true

plugins=(
  git
)
# added for node
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export TERM="xterm-256color"
export PATH=$HOME/bin:/usr/local/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

