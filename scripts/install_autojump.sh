if [ ! -d ~/.dotfiles/autojump ]; then
    git clone https://github.com/wting/autojump.git
    cd autojump
    ./install.py
fi
