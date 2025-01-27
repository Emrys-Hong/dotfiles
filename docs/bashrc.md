#### Author Emrys-Hong
## If not running interactively, don't do anything
    case $- in
      *i*) ;;
        *) return;;
    esac






## Load regular commands
    # Check docs/bash_common.md
    [ -f ~/.bash_common ] && source ~/.bash_common






## Default settings for command prompt
    unset PROMPT_COMMAND

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
    unset color_prompt force_color_prompt
    export TERM=xterm-256color

### PS1 setting 
    # including
    # 0. conda environment
    # 1. CUDA_VISIBLE_DEVICES
    # 2. Current path
    # 3. Git branch and commit status
    # It looks like this:
    # (conda_env)|cuda_numbers|~/path/{main}$
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

### Change Terminal Title
    case "$TERM" in
    xterm*|rxvt*)
      ip_address=$(hostname -I | awk '{print $1}')
      PS1="\[\e]0;${ip_address}\a\]$PS1"
      ;;
    *)
      ;;
    esac







## Command history search and completion

### Input Settings
    bind -f ~/.inputrc
    shopt -s checkwinsize
    shopt -s globstar
    shopt -s autocd
    shopt -s expand_aliases
    bind "TAB:menu-complete"
    bind "set show-all-if-ambiguous on"
    bind "set menu-complete-display-prefix on"

### keep long bash history
    export HISTCONTROL=ignoredups:erasedups
    HISTSIZE=10000
    HISTFILESIZE=10000

### keep unified bash history for all tmux sessions
    shopt -s histappend
    export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

### load bash completion
    if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
    fi

### Fuzzy match for commands
    # Automatically loaded when pressing control + R
    # Installation: git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash

### autojump using "j" without complete folder path
#### Usage: `j <foldername>`
    # Installation
    if [[ ! -s $HOME/.autojump/etc/profile.d/autojump.sh ]]; then
        cd ~/.dotfiles && git clone https://github.com/wting/autojump.git && cd autojump && ./install.py
    fi
    [[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh






## CUDA configurations
#### Usage: `cvd 1,2,4-6` to use GPU 1,2,4,5,6 (it will be shown in PS1)
    export CUDA_DEVICE_ORDER=PCI_BUS_ID
    export PATH="/usr/local/cuda/bin":$PATH
    export LD_LIBRARY_PATH="/usr/local/cuda/lib64":$LD_LIBRARY_PATH
    cvd() {
        local input="$1"
        local result=()

        IFS=',' read -ra segments <<< "$input"
        for segment in "${segments[@]}"; do
            if [[ $segment =~ ([0-9]+)-([0-9]+) ]]; then
                range_seq=$(seq -s, "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}")
                IFS=',' read -ra expanded <<< "$range_seq"
                result+=("${expanded[@]}")
            else
                result+=("$segment")
            fi
        done

        IFS=,; CUDA_VISIBLE_DEVICES="${result[*]}"
        export CUDA_VISIBLE_DEVICES
    }






## Nodejs
    # Installation:
    # mkdir ~/nodejs-latest && cd ~/nodejs-latest
    # wget -c https://nodejs.org/dist/latest/node-v21.2.0-linux-x64.tar.xz -O node-latest.tar.xz
    # tar -xvf node-latest.tar.xz --strip-components=1 
    export NODE_HOME=~/nodejs-latest
    export PATH=$NODE_HOME/bin:$PATH






## SSH
#### Usage: `ssh host_name`
    # Openssh
    # Installation: `sudo apt-get install -y openssh-server && ufw allow 22`
    # host_name are defined in ./ssh/config





## Tmux
#### Install tmux package manager
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

### Export working environment for python and project folder
#### Usage: `,`

    , () {
      tmux set-environment pythonenv "$CONDA_DEFAULT_ENV"
      tmux set-environment workdir "$(pwd)"
      tmux show-environment | grep ^pythonenv
      tmux show-environment | grep ^workdir
    }

### Tmux will automatically open project and activate conda environment when open new section
    pyenv=$(tmux show-environment | grep ^pythonenv= | cut -d'=' -f2-)
    echo $pyenv
    if [ "$pyenv" = "" ]; then
        conda activate
    else
        act "$pyenv"
    fi
    cd $(tmux show-environment | grep ^workdir= | cut -d'=' -f2-)

### Load tmux configuration
    [ -f ~/.tmux.conf ] && tmux source-file ~/.tmux.conf

### Tmux related alias
    als 't' 'tmux'
    als 'ta' 'tmux a'
    als 'tl' 'tmux ls'
