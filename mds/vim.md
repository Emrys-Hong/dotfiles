

## Operators
sample operators | meaning
--- | ---
c | change
d | delete
y | yank to register
~ | swap case
gu | make lowercase
gU | make uppercase(go uppercase)
! | filter to external program
< | shift left
> | shift right
= | unindent

## Text objects
sample objects | meaning
--- | ---
aw | a word(sperated by punctuations and space)
iw | inner word(does not contain white space)
aW | a WORD(separated by white space)
iW | inner WORD
ap | a paragraph
ip | inner paragraph
ab | a bracket
ib | inner bracket


## Motions
sample motions | meaning
--- | ---
% | go to the other matching bracket
[count]+ | down to first non blank char of line with [count] below
[count]- | down to first non blank char of line with [count] above
[count]^ | down to current line non blank char of line with [count]
[count]\| | down to current line non blank char of line with [count]
[count]$ | end of the line with [count] below
[count]f/F{char} | to the next occurance of {char}
[count]t/T{char} | to the before next occurance of {char}
[count] h/j/k/l  | [count] lines left, down, up, or right
[count]]m | go to begining of next [count] method
[count]w/W | go a word to the right
[count]b/B | go a word to the left
[count]e/E | go to end of a word/Word right

## Jumping and Navigation
- `H M L` move your cursor to high middle and low of the screen
- `zt zz zb` move the screen to high middle low but cursor do not move
- `Ctrl-U` move the cursor up a lot
- `Ctrl-D` move the cursor down a lot
- `Ctrl-B` full screen  up
- `Ctrl-F` full screen down  
- `Ctrl-Y` move page down, keep cursor the same
- `Ctrl-E` move page up, keep cursor the same
- `(){}[]` are used to move phrase by phrase or code block by code block or paragraph by paragraph 
- `g;` to move to the last editing place.
- `\`"` jumpt to position where last time you exit the current buffer
- `\`\`` to the position before the lastest jump
- `\`^` jump to the position when insert mode was stopped
- `\`.` jump to the position of last edit
- `:marks` to check all marks
- `:help ']` to check all marks
1. `g; and g,` go to last change and previous change in the change list
1. `Ctrl-O/Ctrl-I` for going back and forward

## Display
- `:noh` CANCEL HIGHLIGHT
- `:ls` (list all buffers)

Edit
- GIVE UP EVERYTHING EDITED: `:e!`
- REPLACE WORDS GLOBALLY `:%s/foo/bar/g`

## --
1. OPEN WITH SPLIT THE WINDOW AT MIDDLE `vi -O <files-to-be-split>`
1. split window `<C-W> s`, vertically split window `<C-W> v`

## Plugins
### Folding
```
zo - opens folds
zc - closes fold
zi                     (remove all folding)
zR                     (open all folding)
ZM                     (close all folding)
```

### GitGutter
You can jump between hunks with `[c` and `]c`. You can preview, stage, and undo hunks with `<leader>hp`, `<leader>hs`, and `<leader>hu` respectively

## Resouces
https://www.youtube.com/watch?v=E-ZbrtoSuzw&list=LLlo2B8IAT9fXNgvsztJa5cQ&index=3&t=0s\
set vim as an ide: https://github.com/jez/vim-as-an-ide\
all about vim: https://www.fullstackpython.com/vim.html \
ctags explained in detail: https://ricostacruz.com/til/navigate-code-with-ctags\
ctags tricks: https://stackoverflow.com/questions/563616/vim-and-ctags-tips-and-tricks\
other vim learning resources:\
https://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html\
vim packages: https://vim.fandom.com/wiki/Use\_Vim\_like\_an\_IDE \
individual methods: https://github.com/yangyangwithgnu/use\_vim\_as\_ide \
a good vimrc(from the website above): https://dougblack.io/words/a-good-vimrc.html \

