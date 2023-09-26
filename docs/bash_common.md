#### Author Emrys-Hong
## Helper function for alias, (can ignore this function)
    als() {
      local func_name="$1"
      local command="$2"

      eval "
      $func_name() {
        local args=\"\$@\"
        local full_command=\"$command \$args\"

        if [[ \"$command\" == git* ]]; then
          local git_alias=\$(git config --get alias.\$args)
            if [[ \"\$git_alias\" == !* ]]; then
              git_alias=\${git_alias:1}
              full_command=\"\$git_alias\"
            else
              full_command=\"$command \$git_alias\"
            fi
        fi

        if [[ \"$command\" == ssh* ]]; then
          local ssh_user=\$(grep -A2 \"Host \$args\" ~/.ssh/config | grep 'User' | awk '{print \$2}')
          local ssh_host=\$(grep -A2 \"Host \$args\" ~/.ssh/config | grep 'HostName' | awk '{print \$2}')
          local local_forwards=\$(grep -A5 \"Host \$args\" ~/.ssh/config | grep 'LocalForward' | awk '{print \"-L \" \$2 \":\" \$3}')
          if [[ \$ssh_user != \"\" && \$ssh_host != \"\" ]]; then
            full_command=\"$command \$ssh_user@\$ssh_host\"
            echo \"User: \$ssh_user\"
            echo \"Hostname: \$ssh_host\"
          fi
        fi
        for lf in \$local_forwards; do
          full_command+=\" \$lf\"
        done

        tput setaf 1
        echo \"\$full_command\"
        tput sgr0
        eval \$full_command
      }
      "
      export -f $func_name
    }


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
    # Install neovim
    # curl -L https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -o ~/.dotfiles/nvim/nvim.appimage
    # chmod u+x ~/.dotfiles/nvim/nvim.appimage
    # sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    if [ -f $HOME/.dotfiles/nvim/nvim.appimage ]; then
        als 'nvim' '$HOME/.dotfiles/nvim/nvim.appimage'
        als 'vi' "nvim -u ~/.config/nvim/init.vim"
        als 'vim' "nvim -u ~/.config/nvim/init.vim"
    fi

    # Ctags generates an index (or tag) file of language objects found in source files for programming languages. For Vim
    # Installation: sudo apt-get -y install exuberant-ctags







## Python related: Conda and useful pip packages
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
    als 'act' 'conda activate'
    als 'deact' 'conda deactivate'
    als 'cl' 'conda info --envs'

    als 'p' 'python'
    als 'py' 'python'

    # ipdb for breakpoint() in python
    # Installation: `pip install ipdb`
    als 'ipdb' 'python -m ipdb -c continue'
    als 'i' 'python -m ipdb -c continue'

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
    als 'smi' "py3smi -w 100"

    # Add the current directory to pythonpath to resolve importing issues
    # Usage `pp`
    als 'pp' 'export PYTHONPATH=$(pwd):$PYTHONPATH'

    # print location of installed python packages
    als 'site' 'python -m site' 

    # For viewing better github history locally
    # Installation: sudo apt-get install -y tig
    als 'tig' 'tig'

    # For comparing differences between files
    # Usage icdiff <filename>
    # Installation `pip install icdiff`
    als 'icdiff' 'icdiff'

    # For viewing tables in terminal
    # Usage: visidata file.csv
    # Installation: `pip install visidata`
    als 'visidata' 'visidata' # csv files

    # Visualizing markdowns
    # Usage: grip <filename> port
    # Installation: `pip install grip`
    als 'grip' 'grip' # render readme

    # Installation `pip install tensorboard`
    # Usage: tb 8080
    als 'tb' 'tensorboard --logdir . --port'

    # Installation: `pip install jupyterlab`
    # Usage: lab 8888
    als 'lab' 'jupyter lab --no-browser --allow-root --port '





## Directories
    # autojump using "j" without complete folder path, usage, j <foldername>
    # Installation
    # cd ~/.dotfiles && git clone https://github.com/wting/autojump.git && cd autojump && ./install.py
    [[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

    # locate to common directories

    # Github projects
    als 'G' 'cd ~/G'
    als 'D' 'cd ~/.dotfiles'

    # go to Parent folders with shortcut
    als '..' 'cd ..'
    als '...' 'cd ../..'
    als '....' 'cd ../../..'
    als '.....' 'cd ../../../..'






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
 
    als 't' 'tmux'
    als 'ta' 'tmux a'






## iTerm2 integration
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
    # Usage: dl <filename>
    als 'dl' 'it2dl'

    # Usage: ul
    als 'ul' 'it2ul'

    # Usage: img <filename>
    als 'img' 'imgcat  -H 1000px -s' # image files






## Daily commands
    # Remove all file name with certain extenstion
    # Usage: `rm_all py`, to remove all python files from directory and subdirectory
    rm_all(){
        find . -name "$1" -type f
        find . -name "$1" -type f -delete
    }

    # Global search in files for folder
    # Installation: sudo apt install -y silversearcher-ag
    # Usage ag -i <pattern> /path


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

    als ll 'ls -FlaSh'
    als la 'ls -A'
    alias 'cp'='cp -iv'
    alias 'mv'='mv -iv'
    als 'r' 'rm -vI'
    alias 'rm'='rm -v'
    als 'rmr' 'rm -vr'
    als 'rm.' 'current_dir=`pwd` && cd .. && rmr $current_dir && current_dir='
    als 'rmrf' 'rm -rf'
    als 'cpr' 'cp -r'
    als 'scpr' 'scp -r'
    als 'g' 'git'

    # Function: git status -s in gitconfig
    als 'gs' 'g s'
    als 'v' 'vi'
    als 'b' 'bash'
    als 's' 'ssh'
    als 'brc' 'source ~/.bashrc'
    als 'zrc' 'source ~/.zshrc'
    als 'bpf' 'source ~/.bash_profile'

    # list disk usage for current folder
    als 'dush' 'du -hxcs * 2>/dev/null | sort -hr'
    # list disk usage for current folder including hidden files
    als 'dusha' 'du -hxcs $(ls -A) 2>/dev/null | sort -hr'

    # Upload and download files using google drive
    # Installation follow https://github.com/glotlabs/gdrive
    als 'drive' '~/.dotfiles/gdrive'

## Load locally defined commands
    [ -f ~/.bash_local ] && source ~/.bash_local
