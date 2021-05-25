set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

call plug#begin('~/.vim/plugged')

" UI "
Plug 'vim-airline/vim-airline'
let g:airline_detect_paste=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 | let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_c = '%F'
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#ale#enabled = 1
Plug 'dracula/vim', { 'name': 'dracula' }

" Functional "
Plug 'kalekundert/vim-coiled-snake'
Plug 'Konfekt/FastFold'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar', {'on': 'TagbarOpenAutoClose'}
let g:tagbar_sort = 0 | let g:tagbar_foldlevel = 1
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
let g:NERDTreeWinPos = "right"
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Navigation "
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
" Tabnine::sem
Plug 'zxqfl/tabnine-vim'
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle'}
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
let g:ale_fixers = {'python': ['isort', 'autoimport'], 'markdown': ['prettier'], 'sh': ['shfmt']}
let g:ale_linters = {'python': ['pyright', 'mypy', 'pyls'], 'sh': ['shellcheck']}
let g:ale_completion_enabled = 1 | let g:ale_completion_autoimport = 1
let g:ale_set_highlights = 0 | let g:ale_set_signs = 0
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['python']
let g:python_highlight_space_errors = 0
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'mattboehm/vim-unstack' | let g:unstack_mapkey='<F12>'

call plug#end()
colorscheme dracula
