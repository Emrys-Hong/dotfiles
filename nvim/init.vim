set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

call plug#begin('~/.vim/plugged')

" UI "
Plug 'vim-airline/vim-airline'
let g:airline_section_z = '' | let g:airline_section_y = ''
let g:airline_section_error = '' | let g:airline_section_warning = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%{expand("%:p")}'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Functional "
Plug 'kalekundert/vim-coiled-snake'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
let g:tagbar_sort = 0 | let g:tagbar_foldlevel = 1 | let g:tagbar_left = 1 | let g:tagbar_vertical = 25
Plug 'preservim/nerdtree'
let g:NERDTreeWinPos = "left"
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
Plug 'pseewald/nerdtree-tagbar-combined'
Plug 'jistr/vim-nerdtree-tabs'

" Navigation "
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" Langauge "
Plug 'Raimondi/delimitMate' | let delimitMate_expand_cr = 1
" Plug 'zxqfl/tabnine-vim' Tabnine::sem
Plug 'github/copilot.vim'
" :Copilot setup
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle'}
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
Plug 'dense-analysis/ale'
let g:ale_fixers = {'python': ['isort', 'autoimport'], 'markdown': ['prettier'], 'sh': ['shfmt']} "requires pip packages, check scripts/requirements.txt
let g:ale_linters = {'python': ['pyright', 'mypy', 'pyls', 'isort'], 'sh': ['shellcheck']} "requires pip packages
let g:ale_completion_enabled = 1 | let g:ale_completion_autoimport = 1 | let g:ale_lint_on_save = 1
let g:ale_set_highlights = 0 | let g:ale_set_signs = 0
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['python']
let g:python_highlight_space_errors = 0
":UpdateRemotePlugins if semshi have problem
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'vim-plug'] }
" Plug 'mattboehm/vim-unstack' | let g:unstack_mapkey='<F12>'

call plug#end()
colorscheme catppuccin-latte
hi Normal guibg=NONE ctermbg=NONE
highlight semshiUnresolved cterm=underline ctermbg=Red ctermfg=White gui=underline guibg=Red guifg=White

" mappings
map                       f               <Plug>(easymotion-bd-f)
map                       gw              <Plug>(easymotion-bd-w)
map                       gj              <Plug>(easymotion-bd-jk)
nmap                      f               <Plug>(easymotion-overwin-f)
nmap                      gw              <Plug>(easymotion-overwin-w)
nmap                      gj              <Plug>(easymotion-overwin-line)
nmap                      <CR>            za
" zM for More fold and zR for Reduce fold

nnoremap          <leader>,               :NERDTreeToggle<CR>:TagbarToggle<CR>

nnoremap                  /               :Lines<CR>
nnoremap                  gd              :w<CR>:ALEGoToDefinition<CR>
nnoremap                  gf              :w<CR>$F( h:ALEGoToDefinition<CR>
nnoremap                  gr              :w<CR>:ALEFindReferences<CR>
nnoremap          <Leader>i               :ALEFix<CR>

" search
nnoremap          <leader>m               :Maps<CR>
nnoremap          <leader>:               :Commands<CR>
nnoremap          <leader>`               :Marks<CR>
nnoremap          <leader>/               :Ag<CR>
nnoremap          <leader>?               :Helptags<CR>
nnoremap          <Leader>f               :Files<CR>
tnoremap          <Leader>f               <C-\><C-n>:q<CR>
nnoremap          <S-T>                   :Tags<CR>

nnoremap          <leader>pi              :PlugInstall<CR>
nnoremap          <leader>t               :TagbarOpenAutoClose<CR>
nnoremap          <leader>b               :Buffers<CR>

" nnoremap          <leader>ru              :IndentLinesToggle<CR>
" nnoremap          <leader>rn              :ALERename<CR>
" nnoremap          <leader>s               yy:silent! UnstackFromText('<C-R>"')<CR>
