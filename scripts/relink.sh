#!/bin/bash

set -e

# New base dotfiles directory
NEW_DOTFILES="$HOME/.dotfiles/"

# List of dotfiles to relink
FILES=(
  .bash_common
  .bash_profile
  .bashrc
  .condarc
  .gitattributes_global
  .gitconfig
  .gitignore_global
  .inputrc
  .profile
  .ssh
  .tmux.conf
  .vimrc
  .zshrc
)

echo "Relinking dotfiles to $NEW_DOTFILES"

for file in "${FILES[@]}"; do
  TARGET="$HOME/$file"
  DOTFILE_SRC="$NEW_DOTFILES/${file#.}"  # remove leading dot from filename

  # Special cases where filename doesn't match exactly
  case "$file" in
    .bash_common) DOTFILE_SRC="$NEW_DOTFILES/bash_common" ;;
    .bash_profile) DOTFILE_SRC="$NEW_DOTFILES/bash_profile" ;;
    .bashrc) DOTFILE_SRC="$NEW_DOTFILES/bashrc" ;;
    .condarc) DOTFILE_SRC="$NEW_DOTFILES/condarc" ;;
    .gitattributes_global) DOTFILE_SRC="$NEW_DOTFILES/gitattributes_global" ;;
    .gitconfig) DOTFILE_SRC="$NEW_DOTFILES/gitconfig" ;;
    .gitignore_global) DOTFILE_SRC="$NEW_DOTFILES/gitignore_global" ;;
    .inputrc) DOTFILE_SRC="$NEW_DOTFILES/inputrc" ;;
    .profile) DOTFILE_SRC="$NEW_DOTFILES/profile" ;;
    .ssh) DOTFILE_SRC="$NEW_DOTFILES/ssh" ;;
    .tmux.conf) DOTFILE_SRC="$NEW_DOTFILES/tmux.conf" ;;
    .vimrc) DOTFILE_SRC="$NEW_DOTFILES/vimrc" ;;
    .zshrc) DOTFILE_SRC="$NEW_DOTFILES/zshrc" ;;
  esac

  # Unlink existing symlink or backup regular file
  if [ -L "$TARGET" ]; then
    echo "Unlinking $TARGET"
    unlink "$TARGET"
  elif [ -e "$TARGET" ]; then
    echo "Backing up existing file $TARGET to $TARGET.backup"
    mv "$TARGET" "$TARGET.backup"
  fi

  echo "Linking $TARGET -> $DOTFILE_SRC"
  ln -s "$DOTFILE_SRC" "$TARGET"
done

echo "All dotfiles relinked to $NEW_DOTFILES."
