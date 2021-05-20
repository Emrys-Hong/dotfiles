set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
call plug#begin('~/.vim/plugged')
" UI
Plug 'dracula/vim', { 'name': 'dracula' }
" Functional
Plug 'airblade/vim-gitgutter'
" Navigation "
Plug 'majutsushi/tagbar', {'on': 'TagbarOpenAutoClose'}
let g:tagbar_sort = 0 | let g:tagbar_foldlevel = 1
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
" Langauge "
Plug 'Raimondi/delimitMate' | let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END
Plug 'tpope/vim-commentary'
Plug 'mattboehm/vim-unstack' | let g:unstack_mapkey='<F12>'
call plug#end()
colorscheme peachpuff
