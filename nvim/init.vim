set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

call plug#begin('~/.vim/plugged')

" UI "
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_section_z = '' | let g:airline_section_y = ''
" Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Functional "
Plug 'kalekundert/vim-coiled-snake'
Plug 'Konfekt/FastFold'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
let g:tagbar_sort = 0 | let g:tagbar_foldlevel = 1 | let g:tagbar_left = 1 | let g:tagbar_vertical = 25
Plug 'preservim/nerdtree'
let g:NERDTreeWinPos = "left"
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
Plug 'pseewald/nerdtree-tagbar-combined'
Plug 'yegappan/mru'
Plug 'jistr/vim-nerdtree-tabs'

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
" Plug 'zxqfl/tabnine-vim' Tabnine::sem
Plug 'github/copilot.vim'
" :Copilot setup
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
":UpdateRemotePlugins if semshi have problem
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'vim-plug'] }
" Plug 'mattboehm/vim-unstack' | let g:unstack_mapkey='<F12>'

call plug#end()
" colorscheme dracula
colorscheme catppuccin-latte
