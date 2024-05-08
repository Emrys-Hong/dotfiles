#!/bin/bash

REMOTE_HOST="root@157.230.44.85"

IP_PART=$(hostname -I | cut -d' ' -f1 | awk -F '.' '{print $4}')

REMOTE_PORT="17$IP_PART"
M_PORT="18$IP_PART"

SSH_OPTIONS="-M ${M_PORT}  -N -f -R StrictHostKeyChecking=no ${REMOTE_PORT}:localhost:22"

export AUTOSSH_DEBUG=1

LOG_FILE="/dev/null"


if ! /usr/bin/pgrep -f "[a]utossh"; then
    AUTOSSH_POLL=10 /usr/bin/autossh $SSH_OPTIONS $REMOTE_HOST > $LOG_FILE 2>&1
fi

# add the following to crontab
# */5 * * * * $HOME/.dotfiles/scripts/sshtunnel.sh
