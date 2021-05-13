if [ ! -f ~/.dotfiles/nvim/nvim.appimage ]; then
    curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o nvim/nvim.appimage
    chmod u+x nvim/nvim.appimage
    sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
