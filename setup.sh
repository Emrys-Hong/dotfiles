#!/bin/bash
set -x

mkdir -p ~/G ~/Trash_Bin ~/Archived_Projects ~/Data

declare -a files=("tmux.conf" "vimrc" "bashrc" "bash_profile" "zshrc" "profile" "inputrc" "gitignore_global" "gitattributes_global" "gitconfig" "condarc")
for file in "${files[@]}"; do
    [ -e ~/.$file ] && rm ~/.$file
    ln -s ~/.dotfiles/${file} ~/.$file
done

[ -e ~/.config/nvim ] && rm ~/.config/nvim
ln -s ~/.dotfiles/nvim ~/.config/nvim

ln -s ~/.dotfiles/settings/default.json ~/.config/karabiner/assets/complex_modifications/default.json

if [ -d ~/.ssh ]; then
    mv ~/.ssh/* ~/.dotfiles/ssh/
    rm -r ~/.ssh
fi
ln -s ~/.dotfiles/ssh ~/.ssh


bind -f  ~/.inputrc

touch ~/.bash_local

echo "Finish"
