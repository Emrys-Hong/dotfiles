" Source: https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23

let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1
let s:monkey_terminal_window_size = -1

function! MonkeyTerminalOpen()
  if !bufexists(s:monkey_terminal_buffer)
    new monkey_terminal
    wincmd J
    resize 15
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })
     silent file Terminal\ 1
     let s:monkey_terminal_window = win_getid()
     let s:monkey_terminal_buffer = bufnr('%')
    set nobuflisted
    call feedkeys('A')
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    wincmd J   
    execute "resize " . s:monkey_terminal_window_size 
    buffer Terminal\ 1
     let s:monkey_terminal_window = win_getid()
    endif
    call feedkeys('A')
  endif
endfunction
function! MonkeyTerminalClose()
  if win_gotoid(s:monkey_terminal_window)
    let s:monkey_terminal_window_size = winheight(s:monkey_terminal_window) 
    hide
  endif
endfunction


function! MonkeyTerminalOpenSpace()
  if !bufexists(s:monkey_terminal_buffer)
    new monkey_terminal
    wincmd J
    resize 15
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })
     silent file Terminal\ 1
     let s:monkey_terminal_window = win_getid()
     let s:monkey_terminal_buffer = bufnr('%')
    set nobuflisted
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    wincmd J   
    execute "resize " . s:monkey_terminal_window_size 
    buffer Terminal\ 1
     let s:monkey_terminal_window = win_getid()
    endif
  endif
endfunction
function! MonkeyTerminalToggleSpace()
  if win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalClose()
  else
    call MonkeyTerminalOpenSpace()
  endif
endfunction

function! MonkeyTerminalExec(cmd)
  if !win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalOpen()
  endif
  call jobsend(s:monkey_terminal_job_id, "clear\n")
  call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
  normal! G
  wincmd J
endfunction

nnoremap          <Space> :call MonkeyTerminalToggleSpace()<CR>

augroup py
    autocmd!
    autocmd BufRead,BufNewFile *.py set filetype=python
    autocmd FileType python nnoremap <S-E> :call MonkeyTerminalExec('p ' . expand('%'))<CR>
augroup END
