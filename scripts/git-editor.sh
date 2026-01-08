#!/bin/bash

# Check the number of arguments
if [ $# -ne 1 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

file=$1

# Check the operating system and set the editor accordingly
if [[ "$(uname)" == "Linux" ]]; then
  editor="/usr/bin/vim"
elif [[ "$(uname)" == "Darwin" ]]; then
  editor="/usr/bin/vim"
else
  echo "Unsupported operating system."
  exit 1
fi

# Set the editor for Git
export GIT_EDITOR="$editor"

# Run the chosen editor command with the provided file
$GIT_EDITOR "$file"

