# Tmux installation

```sh
wget -O ~/.tmux.conf https://raw.githubusercontent.com/Emrys-Hong/dotfiles/main/tmux.conf

echo "tmux source-file ~/.tmux.conf" >> ~/.bashrc

tmux source-file ~/.tmux.conf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## My frequent shortcuts

```
prefix = Ctrl + A
session includes multiple windows, windows includes multiple tabs
tmux # new session
tmux a # attach session
prefix then d # detach last session (d for detach)
prefix then l # list sessions, windows / switch sessions (l for list)
prefix then q # list tabs
prefix then t # new window (t for tab)
prefix then j # select previous window
prefix then k # select next window
prefix then m # toggle mouse on/off (mouse on to use mouse clicking/scrolling, mouse off for select and copy/paste)
prefix then s # rename session (s for session)
prefix then n # rename window (n for name)
prefix then w # kill window (w for window)
Ctrl + D      # kill tab
prefix then | # split window horizontally
prefix then _ # split window vertically
prefix then [esc] # enter visual mode, use 'v' for selection 'y' for copy 'p' for paste (similar to vim)
prefix then z # toggle zoom in/ zoom out of certain tab
prefix then I # use for install tmux plugins (capital I for install), such as GPU usage function in status bar
prefix then r # reload tmux.conf file (if you change the tmux.conf need to reload to take effect)
```
