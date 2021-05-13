# tmux cheat sheet

> (C-x means ctrl+x, M-x means alt+x)

## Getting help

Display a list of keyboard shortcuts:

    C-a ?

## Managing sessions

Kill all the session:

    tmux kill-server
    tmux kill-session

Switch between sessions:

    C-a (          previous session
    C-a )          next session
    C-a {          move the current pane to the previous position
    C-a }          move the current pane to the next position

Rename:

    C-a $          rename the current session
    C-a ,          rename the current window


Switch between windows:

    C-a 1 ...      switch to window 1, ..., 9, 0

## More resources
Tmux Cheetsheet(https://tmuxcheatsheet.com/)

Config for remote server(https://gist.github.com/dbeckham/655da225f1243b2db5da)
