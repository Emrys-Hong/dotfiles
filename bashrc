# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac






## Load regular commands
[ -f ~/.bash_local ] && source ~/.bash_local
[ -f ~/.bash_common ] && source ~/.bash_common






## Display Prompt and default editor
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

export PS1=$Color_Off'$([ -z "${CUDA_VISIBLE_DEVICES}" ] || echo "|$CUDA_VISIBLE_DEVICES|")$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "'$BIBlue$PathShort'$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$BGreen'"$(__git_ps1 "(%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$BIRed'"$(__git_ps1 "{%s}"); \
  fi)'$Black'\$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo "'$BIBlue$PathShort$Black'\$ "; \
fi)'

LS_COLORS=$LS_COLORS:'fi=0;30:'

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

unset color_prompt force_color_prompt
export VISUAL="vim"
export EDITOR="vim"
export TERM=xterm-256color






## Command history search and completion
bind -f ~/.inputrc
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd
shopt -s expand_aliases
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

export HISTCONTROL=ignoredups:erasedups
HISTSIZE=10000
HISTFILESIZE=10000
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash






## CUDA
export CUDA_DEVICE_ORDER=PCI_BUS_ID
export PATH="/usr/local/cuda/bin":$PATH
export LD_LIBRARY_PATH="/usr/local/cuda/lib64":$LD_LIBRARY_PATH
cvd(){
    export CUDA_VISIBLE_DEVICES="$1"
}





## Extra Settings
export NODE_HOME=~/nodejs-latest
export PATH=$NODE_HOME/bin:$PATH

