## Useful libraries

### Jupyter notebook related
Enable install jupyter notebook extension
```
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
```

Enable Jupyter Notebook passwordless login (not recommend)
```
python scripts/jupyter_without_password_setup.py
```

### Linux packages

Ctags generates an index (or tag) file of language objects found in source files for programming languages. For Vim
```
sudo apt-get -y install exuberant-ctags
```

Openssh
```
sudo apt-get install -y openssh-server && ufw allow 22
```

Global search in files
```
sudo apt install -y silversearcher-ag
```

Git history
```
sudo apt-get install -y tig
```

Fuzzy matching for commands
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
```

Tmux package manager
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Mac packages

Bash completion
```
brew install bash-completion
```

Neovim
```
brew install neovim
```

### Pip packages
```
neovim # VIM related
pynvim # VIM related
powerline-status # VIM
pyls # VIM python language server (for autocompletion etc)
pydantic # python type import
py3nvml # python nvidia gpu monitoring
ipdb # python debugging
jupyterlab # Jupyter
visidata # For viewing tables in terminal | visidata file.csv
icdiff # For comparing differences between files | Usage icdiff
grip # Visualizing markdowns | Usage: grip <filename> port
```

### Others

Jump to history folders
```
cd ~/.dotfiles
git clone https://github.com/wting/autojump.git
cd autojump
./install.py
```


Install miniconda
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

Neovim Linux
```
curl -L https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -o ~/.dotfiles/nvim/nvim.appimage
chmod u+x ~/.dotfiles/nvim/nvim.appimage
sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Nodejs
```
cd ~/.dotfiles/scripts/install_nodejs.sh
bash install_nodejs.sh
```
