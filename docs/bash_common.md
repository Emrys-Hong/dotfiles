#### Author Emrys-Hong

## Helper function for alias, It will display the expanded alias command and execute it, 
    print_in_color() {
        local input_string="$1"
        tput setaf 2
        echo "$input_string"
        tput sgr0
    }
#### Usage: `als func_name command`
    als() {
      local func_name="$1"
      local command="$2"

      eval "
      $func_name() {
        local args=\"\$@\"
        local full_command=\"$command \$args\"

        if [[ \"$command\" == git* ]]; then
          local git_alias=\$(git config --get alias.\$1)
          local rest_args=\${args[@]:2}
          if [[ \"\$git_alias\" != \"\" ]]; then
            if [[ \"\$git_alias\" == !* ]]; then
              git_alias=\${git_alias:1}
              full_command=\"\$git_alias\"
            else
              full_command=\"$command \$git_alias \$rest_args\"
            fi
          else
            full_command=\"$command \$args\"
          fi
        fi

        if [[ \"$command\" == ssh* ]]; then
          local ssh_user=\$(grep -A2 \"Host \$args\" ~/.ssh/config | grep 'User' | awk '{print \$2}')
          local ssh_host=\$(grep -A2 \"Host \$args\" ~/.ssh/config | grep 'HostName' | awk '{print \$2}')
          local local_forwards=\$(grep -A5 \"Host \$args\" ~/.ssh/config | grep 'LocalForward' | awk '{print \"-L \" \$2 \":\" \$3}')
          if [[ \$ssh_user != \"\" && \$ssh_host != \"\" ]]; then
            full_command=\"$command \$ssh_user@\$ssh_host\"
            print_in_color \"User: \$ssh_user\"
            print_in_color \"Hostname: \$ssh_host\"
          fi
        fi
        for lf in \$local_forwards; do
          full_command+=\" \$lf\"
        done

        print_in_color \"\$full_command\"
        eval \$full_command
      }
      "
      export -f $func_name
    }






## Enable colors
    [ -f ~/.dotfiles/scripts/color.sh ] && source ~/.dotfiles/scripts/color.sh
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi






## Vim
### Vim as default editor
    export VISUAL=vim
    export EDITOR="$VISUAL"

### Install neovim
    if [ ! -f ~/.dotfiles/nvim/nvim.appimage ]; then
        curl -L https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -o ~/.dotfiles/nvim/nvim.appimage
        chmod u+x ~/.dotfiles/nvim/nvim.appimage
        sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    fi

### Use Neovim as vim
    if [ -f $HOME/.dotfiles/nvim/nvim.appimage ]; then
        als 'nvim' '$HOME/.dotfiles/nvim/nvim.appimage'
        als 'vim' "nvim -u ~/.dotfiles/nvim/init.vim"
    fi

### helper function
    vi() {
        local abspath=$(realpath "$1")
        cmd="nvim -u ~/.dotfiles/nvim/init.vim $abspath"
        history -s "vi $abspath"
        eval $cmd
    }






## Python

### Install miniconda
    #cd $HOME && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    #bash Miniconda3-latest-Linux-x86_64.sh


### Initialize miniconda
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

### load .condarc
    [ -f $HOME/.dotfiles/condarc ] && export 'CONDARC'="$HOME/.dotfiles/condarc"

### Open vim and Go to line in stacktrace in python
#### Usage: `File "path/to/script.py", line 97, in method`
    File() {
        local input="$@"
        local file_path=$(echo "$1" | sed 's/,$//')
        local line_num=$(echo "$input" | awk -F'line ' '{print $2}' | awk -F',' '{print $1}')
        local cmd="$HOME/.dotfiles/nvim/nvim.appimage -u ~/.config/nvim/init.vim +$line_num $file_path -c 'normal zt'"
        print_in_color "$cmd"
        eval $cmd
    }

### Common aliases related to python and conda
    function act() {
        conda activate "$@"
        export OLD_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
        export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH
    }
    function deact() {
        conda deactivate
        export LD_LIBRARY_PATH=$OLD_LD_LIBRARY_PATH
        unset OLD_LD_LIBRARY_PATH
    }
    als 'cl' 'conda info --envs'
    als 'p' 'python'
    als 'py' 'python'

### ipdb for breakpoint() in python
#### `pip install git+https://github.com/Emrys-Hong/custom_debugger/`
    als 'ipdb' 'python -m ipdb -c continue'
    als 'i' 'python -m ipdb -c continue'
    export PYTHONBREAKPOINT=ipdb.set_trace

### Install common packages in [here](../scripts/requirements.txt)
### Usage: `pipin`
    pipin ()
    {
        pip install -r ~/.dotfiles/scripts/requirements.txt --upgrade
    }

### Better alternative for nvidia-smi, Usage: smi, Installation: `pip install py3smi`
#### Usage: `smi`
    als 'smi' "py3smi -w 100"

### Add the current directory to pythonpath to resolve importing issues, 
#### Usage: `pp`
    als 'pp' 'export PYTHONPATH=$(pwd):$PYTHONPATH'

### print location of installed python packages
#### Usage: `site`
    als 'site' 'python -m site' 

### Other useful pip libraries
#### Usage: `tig`
    # For viewing better github history locally
    # Installation: sudo apt-get install -y tig
    als 'gl' 'tig'

    # For comparing differences between files
    # Usage icdiff <filename1> <filename2>
    # Installation `pip install icdiff`
    als 'diff' 'icdiff'

    # For viewing tables in terminal
#### Usage: `visidata file.csv`
    # Installation: `pip install visidata`
    als 'table' 'visidata' # csv files

#### Usage: `grip <filename> port`
    # Visualizing markdowns
    # Installation: `pip install grip`
    als 'markdown' 'grip' # render readme

#### Usage: `lab <port>`
    # Installation: `pip install jupyterlab`
    als 'lab' 'jupyter lab --no-browser --allow-root --port '





## Directories

### autojump using "j" without complete folder path
#### Usage: `j <foldername>`
    # Installation
    if [[ ! -s $HOME/.autojump/etc/profile.d/autojump.sh ]]; then
        cd ~/.dotfiles && git clone https://github.com/wting/autojump.git && cd autojump && ./install.py
    fi
    [[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh


### Folder shortcuts
    als 'G' 'cd ~/G'
    als 'D' 'cd ~/.dotfiles'

### Go to Parent folders with shortcut
    als '..' 'cd ..'
    als '...' 'cd ../..'
    als '....' 'cd ../../..'
    als '.....' 'cd ../../../..'











## iTerm2 integration
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
#### Usage in iterm2: `dl <filename>`
    als 'dl' 'it2dl'

#### Usage in iterm2: `ul`
    als 'ul' 'it2ul'

#### Usage in iterm2: `img <filename>`
    als 'img' 'imgcat  -H 1000px -s' # image files

### Upload and download files using google drive
    # Installation follow https://github.com/glotlabs/gdrive
    als 'drive' '~/.dotfiles/gdrive'
    als 'dul' '~/.dotfiles/gdrive files upload'







## Other Useful commands
### Usage: `rm_all py`, to remove all python files from directory and subdirectory
    rm_all(){
        find . -name "$1" -type f
        find . -name "$1" -type f -delete
    }

### Global search in files for folder
#### Usage `ag -i <pattern> /path`
    # Installation: `sudo apt install -y silversearcher-ag`


### Make directory and cd into it
    mkd ()
    {
        mkdir -pv -- "$1" && cd -P -- "$1"
    }
    alias 'mkdir'='mkdir -pv'

### list directory by ignoring files in .gitignore
#### Usage: `l`
    gitls () {
      if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        print_in_color "git ls-files"
        ls -d1 --color=always -CF $( (git ls-files && git ls-files --exclude-standard --others) | awk -F/ '{if(NF>1){print $1}else{print}}' | sort -u )
      else
        print_in_color "ls --color=always -CF"
        ls --color=always -CF
      fi
    }
    alias l='gitls'

    als ll 'ls -FlaSh'
    als la 'ls -A'


### copy for files and folders between and within machines
#### Usage1: `cp file_or_folder /path/`
#### Usage2: `cp ~/miniconda3/envs/<package_name> username@ip:~/miniconda3/envs/`
    copy() {
      if [ "$#" -lt 2 ]; then
        cmd="cp $@"
        print_in_color "$cmd"; $cmd
        return 0
      fi

      dest="${!#}"  # get the last argument as destination
      # Check if destination is in the format xxx:/path
      if [[ $dest =~ [0-9]+: ]]; then
        # Removing leading / from item if destination is localhost with specific format
        item="$1"
        cmd="rsync -a --info=progress2 $item $dest"
        print_in_color "$cmd"; $cmd

      else
        for item in "${@:1:$(($#-1))}"; do  # iterate over all arguments except the last one
          if [ -f "$item" ] || [ -L "$item" ]; then
            cmd="cp -v $item $dest"
          elif [[ -d $item ]]; then
            count=$(find "$item" -type f | wc -l)
            if (( count < 10 )); then
              cmd="cp -rv $item $dest"
            else
              cmd="cp -r $item $dest"
            fi
          else
            cmd="cp $@"
            print_in_color "$cmd"; $cmd
            return 0
          fi
          print_in_color "$cmd"; $cmd
        done
      fi
    }
    als 'c' 'copy'


### Move files and folders
#### Usage: `mv <folder_or_file> path/`
    move() {
      if [ "$#" -lt 2 ]; then
        cmd="mv $@"
        print_in_color "$cmd"; $cmd
        return 0
      fi

      dest="${!#}"  # get the last argument as destination

      if [ ! -d "$dest" ]; then
        cmd=(mv)
        cmd+=("$@")
        "${cmd[@]}"
        return 0
      fi

      for item in "${@:1:$(($#-1))}"; do  # iterate over all arguments except the last one
        if [ -f "$item" ] || [ -L "$item" ]; then
          cmd="mv -iv $item $dest"
          print_in_color "$cmd"; $cmd
        elif [[ -d $item ]]; then
          cmd="mv -iv $item $dest"
          print_in_color "$cmd"; $cmd
        else
          cmd="mv $@"
          print_in_color "$cmd"; $cmd
          return 0
        fi
     done
    }
    als 'm' 'move'

# rm for files and folders
#### Usage: `rm <folder_or_file> path/`
    remove() {
      if [ "$#" -lt 1 ]; then
        cmd="rm $@"
        print_in_color "$cmd"; $cmd
        return 0
      fi


      for item in "$@"; do
        if [ -f "$item" ] || [ -L "$item" ]; then
          cmd="rm -v $item"
        elif [[ -d $item ]]; then
          count=$(find "$item" -type f | wc -l)
          if (( count < 10 )); then
            cmd="rm -rIv $item"
          else
            cmd="rm -rI $item"
          fi
        else
          cmd="rm $@"
          print_in_color "$cmd"; $cmd
          return 0
        fi
        print_in_color "$cmd"; $cmd
      done
    }
    alias 'rm.'='current_dir=`pwd` && cd .. && rm $current_dir'
    als 'rmrf' 'rm -rf'
    als 'r' 'remove'

### Git alias
    als 'g' 'git'
    # Function: git status -s in gitconfig
    als 'gs' 'g s'

### Alias for source config files
    als 'brc' 'source ~/.bashrc'
    als 'zrc' 'source ~/.zshrc'
    als 'bpf' 'source ~/.bash_profile'

### list disk usage for current folder
#### Usage1: `disk /path` 
#### Usage2 list hidden files: `disk -a /path`
    disk() {
      show_all=0
      dir=""
      cmd=""

      if [ "$1" == "-a" ]; then
          show_all=1
          dir="$2"
      else
          dir="$1"
      fi

      if [ -z "$dir" ]; then
          echo "Please provide a directory path."
          return 1
      fi

      if [ ! -d "$dir" ]; then
          echo "Error: $dir is not a directory."
          return 2
      fi

      if [ $show_all -eq 1 ]; then
          cmd="du -hxcs \"$dir\"/* \"$dir\"/.[^.]* \"$dir\"/..?* 2>/dev/null | sort -hr"
      else
          cmd="du -hxcs \"$dir\"/* 2>/dev/null | sort -hr"
      fi

      # Echo the command
      print_in_color "$cmd"
      # Execute the command
      eval "$cmd"
  }

## Load locally defined commands
    [ -f ~/.bash_local ] && source ~/.bash_local
