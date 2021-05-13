# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [ -f ~/.bash_common ]; then
    source ~/.bash_common
fi

# Display
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

export PS1=$Color_Off'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "'$BIBlue$PathShort'$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$BGreen'"$(__git_ps1 "(%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$BIRed'"$(__git_ps1 "{%s}"); \
  fi)'$Color_Off'\$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo "'$BIBlue$PathShort$Color_Off'\$ "; \
fi)'

unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

bind -f ~/.inputrc
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

export VISUAL="vim"
export EDITOR="vim"
export TERM=xterm-256color

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=10000

# Bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# set gpu device order as their number instead of the fastest
export CUDA_DEVICE_ORDER=PCI_BUS_ID

a 'smi'="py3smi --left"
a 'watchgpu'='watch -c gpustat -cp --color'

# cuda version
# nvcc --version
a 'cuda-version'='cat /usr/local/cuda/version.txt'

# cudnn version
a 'cudnn-version'='cat /usr/local/cuda/include/cudnn.h | grep CUDNN_MAJOR -A 2'

# Libs
a 'lab'='jupyter lab --no-browser --allow-root --port ' # run with port
a 'rstart'='ray start --head --dashboard-port'
a 'rstop'='ray stop'
a 'tb'='tensorboard --logdir . --port' # run locally # Tensorboard Usage: tb <directory>

if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
