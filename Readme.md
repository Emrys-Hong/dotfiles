# Dotfiles
All of configuration files([dotfiles](http://dotfiles.github.io/)) in this repo, using bash as shell script, and neovim as editor

## To setup:
Setup is as simple as:
```
git clone https://github.com/Emrys-Hong/dotfiles ~/.dotfiles && cd ~/.dotfiles
./setup.sh
```
Specifically `setup.sh` will use softlinks to link the configuration files as hidden files to your home directory `~/` (alternatively, you can also choose to link the files yourself).

Configuration files include :

Files
- "tmux.conf" 
- "vimrc" 
- "bashrc" 
- "bash_profile" 
- "bash_common" 
- "zshrc" 
- "profile" 
- "inputrc" 
- "gitignore_global" 
- "gitattributes_global" 
- "gitconfig" 
- "condarc"

Folders
- "ssh"
- "nvim"

### Customize
- Change the `name` and `email` field inside `gitconfig`
- Change `ssh/config` for server address

Explanation for those configurations are included in [docs](docs/libraries.md)

## Tips 
1. `type <cmd>` to check <command> usage in bash
2. `git alias` to check git alias
3. `prefix+?` to check tmux shortcut

## AutoUpdate
```
*/30 * * * * . $HOME/.profile; cd $HOME/.dotfiles/ && /usr/bin/git rev-parse --abbrev-ref HEAD | xargs /usr/bin/git pull --no-rebase origin
```
