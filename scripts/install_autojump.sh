if [ ! -d ~/.dotfiles/autojump ]; then
    git clone git://github.com/wting/autojump.git
    cd autojump
    ./install.py
fi
