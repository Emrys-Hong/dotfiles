filetype plugin indent on
syntax on
set nocompatible
set t_Co=256
set autoread autowrite
set encoding=utf-8
set nobackup noswapfile noundofile
set tags=./tags;
set expandtab
set backspace=indent,eol,start
set showcmd
set incsearch hlsearch
set ignorecase smartcase
set background=dark
set wildmenu wildmode=longest:full,full
set formatoptions-=tc
set clipboard+=unnamedplus
set list listchars=tab:->,trail:.
set splitright
set linebreak
set mouse=a
set number relativenumber
set foldcolumn=0 foldmethod=expr

source ~/.dotfiles/nvim/monkey_terminal.vim

if has("gui_running")
  set guifont=Monaco:h14 | colorscheme peachpuff
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

let s:hidden_all = 0
function! ToggleHiddenAll()
  if s:hidden_all == 0
    let s:hidden_all = 1|set list listchars=
    set noshowmode|set noruler|set laststatus=0|set noshowcmd|set mouse=
    set number!|set relativenumber!|set foldcolumn=0|GitGutterToggle
  else
    let s:hidden_all = 0|set list listchars=tab:->,trail:.
    set showmode|set ruler|set laststatus=2|set showcmd|set mouse=a
    set number!|set relativenumber!|set foldcolumn=1|GitGutterToggle
  endif
endfunction

function! CloseBuffer()
  if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | else | bd | endif
endfunction


let mapleader = '\'
map                       f               <Plug>(easymotion-bd-f)
map                       gw              <Plug>(easymotion-bd-w)
map                       gj              <Plug>(easymotion-bd-jk)
nmap                      f               <Plug>(easymotion-overwin-f)
nmap                      gw              <Plug>(easymotion-overwin-w)
nmap                      gj              <Plug>(easymotion-overwin-line)
nmap                      ;               za
" zM for More fold and zR for Reduce fold
nmap                      ,               <Leader>
vnoremap                  x               "_d
nnoremap                  x               "_x
nnoremap                  _               :new<CR>
nnoremap                  \|              :vnew<CR>
nnoremap                  /               :Lines<CR>
vnoremap                  /               gc
nnoremap                  qq              <Esc>:call CloseBuffer()<CR>
nnoremap                  qa              <Esc>:qa!<CR>
nnoremap                  qw              <Esc>:wq<CR>
nnoremap                  <Down>          L5kzz
nnoremap                  <Up>            H5jzz
nnoremap                  <C-J>           <C-W><C-J>
nnoremap                  <C-K>           <C-W><C-K>
tnoremap                  <C-K>           <C-\><C-n><C-W><C-K>
nnoremap                  <C-L>           <C-W><C-L>
nnoremap                  <C-H>           <C-W><C-H>
nnoremap                  <C-w><left>     <C-w><
nnoremap                  <C-w><right>    <C-w>>
nnoremap                  <C-w><up>       <C-w>+
nnoremap                  <C-w><down>     <C-w>-
nnoremap                  <C-]>           g<C-]>
nnoremap                  <C-A>           gg0vG$
nnoremap                  <C-C>           a<C-C>
nnoremap                  <S-J>           :bprev<CR>
nnoremap                  <S-K>           :bnext<CR>
nnoremap                  <S-T>           :Tags<CR>
vnoremap                  <Tab>           >gv
vnoremap                  <S-Tab>         <gv
nnoremap                  <f1>            :Files<CR>
tnoremap                  <f1>            <C-\><C-n>:q<CR>
tnoremap                  <Esc>           <C-\><C-n>
nnoremap                  t               :MRU<CR>
nnoremap                  gd              :w<CR>:ALEGoToDefinition<CR>
nnoremap                  gf              :w<CR>$F( h:ALEGoToDefinition<CR>
nnoremap                  gr              :w<CR>:ALEFindReferences<CR>
nnoremap                  dW              vbd
nnoremap          <Leader><CR>            :call ToggleHiddenAll()<CR>
nnoremap          <leader>x               :ALEFix<CR>
nnoremap          <Leader>d               Oimport ipdb; ipdb.set_trace()<Esc>
nnoremap                  `d              /pdb.set_trace()<CR>
nnoremap          <leader>m               :Maps<CR>
nnoremap          <leader>:               :Commands<CR>
nnoremap          <leader>`               :Marks<CR>
nnoremap          <leader>/               :Ag<CR>
nnoremap          <leader>?               :Helptags<CR>
nnoremap          <leader>rn              :ALERename<CR>
nnoremap          <leader>q               :q!<CR>
nnoremap          <leader>p               :pu<CR>
nnoremap <silent> <leader>w               :w<CR>
nnoremap          <leader>j               J
nnoremap          <leader>pi              :PlugInstall<CR>
nnoremap          <leader>t               :TagbarOpenAutoClose<CR>
nnoremap          <leader>,               :NERDTreeToggle<CR>:TagbarToggle<CR>
nnoremap          <leader>ru              :IndentLinesToggle<CR>
nnoremap          <leader>b               :Buffers<CR>
nnoremap          <leader>s               yy:silent! UnstackFromText('<C-R>"')<CR>
