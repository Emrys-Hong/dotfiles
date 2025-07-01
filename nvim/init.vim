" Author Emrys-Hong
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
let g:airline_theme='catppuccin'

" Functional "
Plug 'kalekundert/vim-coiled-snake'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
let g:NERDTreeWinPos = "left"
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
Plug 'jistr/vim-nerdtree-tabs'
Plug 'folke/snacks.nvim'
Plug 'coder/claudecode.nvim'

" Navigation "
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" Langauge "
Plug 'Raimondi/delimitMate' | let delimitMate_expand_cr = 1
Plug 'tpope/vim-commentary'
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle'}
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
Plug 'dense-analysis/ale'
let g:ale_fixers = {'python': ['isort', 'autoimport', 'black'], 'markdown': ['prettier'], 'sh': ['shfmt']} "requires pip packages, check scripts/requirements.txt
let g:ale_linters = {'python': ['pylsp', 'pyls'], 'sh': ['shellcheck']} " Check :ALEInfo
let g:ale_completion_enabled = 1 | let g:ale_completion_autoimport = 1 | let g:ale_lint_on_save = 1
let g:ale_set_highlights = 0 | let g:ale_set_signs = 0
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['python']
let g:python_highlight_space_errors = 0
":UpdateRemotePlugins if semshi have problem
Plug 'wookayin/semshi', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'vim-plug'] }


call plug#end()
lua require('claudecode').setup()
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

nnoremap          <leader>,               :NERDTreeToggle<CR>

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
nnoremap          <leader>b               :Buffers<CR>

" Claude Code
inoremap          <C-L>                   <ESC>:ClaudeCodeFocus<CR>
tnoremap          <C-L>                   <C-\><C-n>:ClaudeCodeFocus<CR>
tnoremap          <C-H>                   <C-\><C-n>:wincmd p<CR>
nnoremap          <leader>c               :ClaudeCode --continue<CR>
autocmd VimEnter * lua if vim.fn.exists(':ClaudeCode') == 2 then vim.cmd('silent! ClaudeCode') vim.cmd('wincmd p') vim.cmd('stopinsert') end
