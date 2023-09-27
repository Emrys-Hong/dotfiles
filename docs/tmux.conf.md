#### Author Emrys-Hong

# General Settings
    setw -g xterm-keys on
    setw -g mode-keys vi
    set -g history-limit 50000
    set -sg escape-time 0
    set -g default-terminal "screen-256color"
## Set prefix=Pressing Control and a at same time
    unbind C-b
    set -g prefix C-a
    bind C-a send-prefix
## Mouse on for scrolling, Toggle Mouse on/off by (prefix+m)
    set-option -g mouse on
    unbind m
    bind m set -gF mouse "#{?mouse,off,on}"

# Appearance
## Status Bar UI
    set-option -g pane-border-style fg=colour235
    set-option -ag pane-active-border-style fg=colour240

    set-option -g message-style bg=black
    set-option -ag message-style fg=brightred

    set-option -ag status-bg colour255
    set-option -ag status-fg green 
    set-option -ag status-style dim

    set-window-option -g window-status-style dim,fg=brightblue
    set-window-option -g window-status-current-style bright,fg=brightred


## Status Bar Content
    set-option -g status on
    set -ag status-interval 5
    set -ag status-justify centre
    set-option -ag status-position bottom

    set -g status-left-length 30
    set -g status-left "#[fg=black]GPU #[fg=black]--  #[fg=black]#{gpu}  #[fg=black]"

    set -g status-right-length 45
    set -g status-right "#[fg=black] #S#[fg=black] -- #[fg=black]#h@#[fg=black]#(hostname -I | cut -d'\'' '\'' -f1) #[fg=black]"

# Monitoring for activity but do no show
    setw -g monitor-activity on
    set -g visual-activity off


# Functions by key bindings

### prefix+r to reload tmux config
    unbind r
    bind r source-file ~/.tmux.conf

### Copy Pasting
    unbind [
    bind Escape copy-mode
    unbind p
    bind p paste-buffer
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
    bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

### Moving between windows and panes
    bind-key k next-window
    bind-key j previous-window
    bind C-h select-pane -L
    bind C-j select-pane -D
    bind C-k select-pane -U
    bind C-l select-pane -R

## Session > Window > Pane key bindings
    unbind %
    unbind '"'
#### kill window
    unbind c
    bind-key w kill-window
#### Create new window
    unbind t
    bind-key t new-window

#### Split window vertically
    bind | split-window -h
#### Split window vertically
    bind _ split-window -v

#### Rename sessions and windows
    unbind s
    bind s command-prompt -I "#S" "rename-session '%%'"

    unbind n
    bind n command-prompt -I "#S" "rename-window '%%'"

#### Choose session and window
    bind l choose-tree -s
    unbind '$'

#### Zoom current pane
    unbind z
    bind z resize-pane -Z

#### Shift current window position
    bind-key -n S-Left swap-window -t -1
    bind-key -n S-Right swap-window -t +1

## Plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'danijoo/tmux-plugin-simple-gpu'
    run '~/.tmux/plugins/tpm/tpm'
    # prefix + I to install Plugins
