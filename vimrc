filetype plugin indent on
syntax on
set nocompatible
set t_Co=256
set autoread
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
set foldcolumn=1 foldmethod=expr
set statusline+=%F

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

function! CopyModeToggle()
  set number! | set relativenumber! | set foldcolumn=0
  if &mouse == 'a' | set mouse= | else | set mouse=a | endif
  GitGutterToggle
endfunction

let mapleader = '\'
nmap                      ,               <Leader>
map                       f               <Plug>(easymotion-bd-f)
map                       gw              <Plug>(easymotion-bd-w)
map                       gj              <Plug>(easymotion-bd-jk)
nmap                      f               <Plug>(easymotion-overwin-f)
nmap                      gw              <Plug>(easymotion-overwin-w)
nmap                      gj              <Plug>(easymotion-overwin-line)
vnoremap                  x               "_d
nnoremap                  x               "_x
nnoremap                  ;               :
nnoremap                  \_              :new<CR>
nnoremap                  \|              :vnew<CR>
nnoremap                  /               :Lines<CR>
vnoremap                  /               gc
nnoremap                  ?               :Helptags<CR>
nnoremap                  qq              <Esc>:bd<CR>
nnoremap                  qa              <Esc>:qa!<CR>
nnoremap                  qw              <Esc>:wq<CR>
nnoremap                  <C-D>           L5kzz
nnoremap                  <C-U>           H5jzz
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
nnoremap                  <TAB>           za
nnoremap                  <CR>            :call CopyModeToggle()<CR>
vnoremap                  <Tab>           >gv
vnoremap                  <S-Tab>         <gv
nnoremap                  <f12>           <Esc>:echo expand('%:p')<CR>
nnoremap                  <f1>            :w<CR>:Files<CR>
tnoremap                  <f1>            <C-\><C-n>:q<CR>
tnoremap                  <Esc>           <C-\><C-n>
nnoremap                  gd              :ALEGoToDefinition<CR>
nnoremap                  gf              $F( h:ALEGoToDefinition<CR>
nnoremap                  gr              :ALEFindReferences<CR>
nnoremap          <leader>x               :ALEFix<CR>
nnoremap          <Leader>d               Oimport ipdb; ipdb.set_trace()<Esc>
nnoremap                  `d              /pdb.set_trace()<CR>
nnoremap          <leader>m               :Maps<CR>
nnoremap          <leader>:               :Commands<CR>
nnoremap          <leader>`               :Marks<CR>
nnoremap          <leader>/               :Ag<CR>
nnoremap          <leader>rn              :ALERename<CR>
nnoremap          <Leader>q               :q<CR>
nnoremap          <Leader>p               :pu<CR>
nnoremap <silent> <leader>w               :w<CR>
nnoremap          <leader>j               J
nnoremap          <leader>pi              :PlugInstall<CR>
nnoremap          <leader>t               :TagbarToggle<CR>
nnoremap          <leader>n               :NERDTreeToggle<CR>
nnoremap          <leader>ru              :IndentLinesToggle<CR>
nnoremap          <leader>b               :Buffers<CR>
nnoremap          <leader>s               yy:silent! UnstackFromText('<C-R>"')<CR>
