#!/bin/bash

REMOTE_HOST="root@157.230.44.85"

IP_PART=$(echo $REMOTE_HOST | grep -oP '\d+\.\d+\.\d+\.\K\d+')
REMOTE_PORT="17$IP_PART"

SSH_OPTIONS="-N -f -R ${REMOTE_PORT}:localhost:22"

LOG_FILE="/dev/null"

if ! /usr/bin/pgrep -f "[s]sh $SSH_OPTIONS $REMOTE_HOST"; then
    /usr/bin/ssh $SSH_OPTIONS $REMOTE_HOST >> $LOG_FILE 2>&1
fi

# add the following to crontab
# */5 * * * * $HOME/.dotfiles/scripts/sshtunnel.sh