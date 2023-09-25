## Display color and set default editor as vim
    export VISUAL=vim
    export EDITOR="$VISUAL"
    [ -f ~/.dotfiles/scripts/color.sh ] && source ~/.dotfiles/scripts/color.sh
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi






## Use Neovim as vim
    if [ -f $HOME/.dotfiles/nvim/nvim.appimage ]; then
        alias 'nvim'='$HOME/.dotfiles/nvim/nvim.appimage'
        alias 'vi'="nvim -u ~/.config/nvim/init.vim"
        alias 'vim'="nvim -u ~/.config/nvim/init.vim"
    fi






## Python related
    __conda_setup="$('${HOME}/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "${HOME}/miniconda3/etc/profile.d/conda.sh" ]; then
            . "${HOME}/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="${HOME}/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # Install Miniconda
    # wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    # bash Miniconda3-latest-Linux-x86_64.sh

    # load .condarc
    if [ -f $HOME/.dotfiles/condarc ]; then
        export 'CONDARC'="$HOME/.dotfiles/condarc"
    fi

    # Go to line in stacktrace in python
    # Usage: File "path/to/script.py", line 97, in method
    File() {
        local input="$@"
        local file_path=$(echo "$1" | sed 's/,$//')
        local line_num=$(echo "$input" | awk -F'line ' '{print $2}' | awk -F',' '{print $1}')
        local cmd="$HOME/.dotfiles/nvim/nvim.appimage -u ~/.config/nvim/init.vim +$line_num $file_path -c 'normal zt'"
        echo "$cmd"
        eval $cmd
    }

    # Common conda aliases
    alias 'act'='conda activate'
    alias 'deact'='conda deactivate'
    alias 'cl'='conda info --envs'

    alias 'p'='python'
    alias 'py'='python'

    # ipdb for breakpoint() in python
    # Installation: `pip install ipdb`
    alias 'ipdb'='python -m ipdb -c continue'
    alias 'i'='python -m ipdb -c continue'

    # Set ipdb for `breakpoint()` in python
    export PYTHONBREAKPOINT=ipdb.set_trace

    # Install the following required packages
    pipin ()
    {
        pip install -r ~/.dotfiles/scripts/requirements.txt --upgrade
    }

    # Better UI for nvidia-smi
    # Usage: smi
    # Installation: `pip install py2smi`
    alias 'smi'="py3smi -w 100"

    # Add the current directory to pythonpath to resolve importing issues
    # Usage `pp`
    alias 'pp'='export PYTHONPATH=$(pwd):$PYTHONPATH'

    # print location of installed python packages
    alias 'site'='python -m site' 

    # For viewing better github history locally
    # Installation: sudo apt-get install -y tig
    alias 'tig'='tig'

    # For comparing differences between files
    # Usage icdiff <filename>
    # Installation `pip install icdiff`
    alias 'icdiff'='icdiff'

    # For viewing tables in terminal
    # Usage: visidata file.csv
    # Installation: `pip install visidata`
    alias 'visidata'='visidata' # csv files

    # Visualizing markdowns
    # Usage: grip <filename> port
    # Installation: `pip install grip`
    alias 'grip'='grip' # render readme

    # Installation `pip install tensorboard`
    # Usage: tb 8080
    alias 'tb'='tensorboard --logdir . --port'

    # Installation: `pip install jupyterlab`
    # Usage: lab 8888
    alias 'lab'='jupyter lab --no-browser --allow-root --port '





## Directories
    # autojump using "j" without complete folder path, usage, j <foldername>
    # Installation
    # cd ~/.dotfiles && git clone https://github.com/wting/autojump.git && cd autojump && ./install.py
    [[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

    # locate to common directories

    # Github projects
    alias 'G'='cd ~/G'
    alias 'D'='cd ~/.dotfiles'

    # go to Parent folders with shortcut
    alias '..'='cd ..'
    alias '...'='cd ../..'
    alias '....'='cd ../../..'
    alias '.....'='cd ../../../..'






## Tmux
    # Install tmux package manager
    # git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # Export working environment for python and project folder
    # Tmux will automatically open project and activate conda environment when open new section
    # Usage: ee

    ee () {
      tmux set-environment pythonenv "$CONDA_DEFAULT_ENV"
      tmux set-environment workdir "$(pwd)"
      tmux show-environment | grep ^pythonenv
      tmux show-environment | grep ^workdir
    }

    # Use load tmux configuration
    [ -f ~/.tmux.conf ] && tmux source-file ~/.tmux.conf \
    && tmux send-keys "conda activate $(tmux show-environment | grep ^pythonenv= | cut -d'=' -f2-)" C-m \
    && tmux send-keys "cd $(tmux show-environment | grep ^workdir= | cut -d'=' -f2-)" C-m
 
    alias 't'='tmux'
    alias 'ta'='tmux a'






## iTerm2 integration
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
    # Usage: dl <filename>
    alias 'dl'='it2dl'

    # Usage: ul
    alias 'ul'='it2ul'

    # Usage: img <filename>
    alias 'img'='imgcat  -H 1000px -s' # image files






## Daily commands
    # remove all file name with certain extenstion
    # Usage: `rm_all py`, to remove all python files from directory and subdirectory
    rm_all(){
        find . -name "$1" -type f
        find . -name "$1" -type f -delete
    }

    # Make directory and cd into it
    mkd ()
    {
        mkdir -pv -- "$1" && cd -P -- "$1"
    }
    alias 'mkdir'='mkdir -pv'

    # list directory by ignoring files in .gitignore
    gitls () {
      if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        ls -d1 --color=always -CF $( (git ls-files && git ls-files --exclude-standard --others) | awk -F/ '{if(NF>1){print $1}else{print}}' | sort -u )
      else
        ls --color=always -CF
      fi
    }
    alias l='gitls'

    alias a='alias'
    alias ll='ls -FlaSh'
    alias la='ls -A'
    alias 'cp'='cp -iv'
    alias 'mv'='mv -iv'
    alias 'rmi'='rm -vI'
    alias 'rm'='rm -v'
    alias 'rmr'='rm -vr'
    alias 'rm.'='current_dir=`pwd` && cd .. && rmr $current_dir && current_dir='
    alias 'rmrf'='rm -rf'
    alias 'cpr'='cp -r'
    alias 'scpr'='scp -r'
    alias 'g'='git'
    # git status -s in gitconfig
    alias 'gs'='g s' 
    alias 'v'='vi'
    alias 'b'='bash'
    alias 'brc'='source ~/.bashrc'
    alias 'zrc'='source ~/.zshrc'
    alias 'bpf'='source ~/.bash_profile'

    # list disk usage for current folder
    alias 'dush'='du -hxcs * 2>/dev/null | sort -hr'

    # list disk usage for current folder including hidden files
    alias 'dusha'='du -hxcs $(ls -A) 2>/dev/null | sort -hr'

    # Upload and download files using google drive
    # Installation follow https://github.com/glotlabs/gdrive
    alias 'drive'='~/.dotfiles/gdrive'
