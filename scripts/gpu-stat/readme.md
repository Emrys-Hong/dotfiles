# [Website](http://172.17.240.73:8080)
## GPU
Run logging and synchronization script in a crontab job by `crontab -e`, every 5 mins

### On individual server
(ensure miniconda is installed)
```
*/5 * * * * $HOME/miniconda3/bin/python $HOME/.dotfiles/scripts/gpu-stat/log_gpu_usage.py
```
and sometimes need to put this in sudo crontab as well
```
0 */5 * * * /usr/sbin/ip link delete docker0
```

### On the central server
(Ensure .ssh/config is set and ssh-copy-id have done)
(try `ssh xxx` can run smoothly)
```
*/5 * * * * rsync -avz --progress  --include='*.csv' --include='*.txt' --exclude='*' 119:~/.dotfiles/scripts/gpu-stat/ ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress  --include='*.csv' --include='*.txt' --exclude='*' 107:~/.dotfiles/scripts/gpu-stat/ ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress  --include='*.csv' --include='*.txt' --exclude='*' 195:~/.dotfiles/scripts/gpu-stat/ ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress  --include='*.csv' --include='*.txt' --exclude='*' 100:~/.dotfiles/scripts/gpu-stat/ ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress  --include='*.csv' --include='*.txt' --exclude='*' 231:~/.dotfiles/scripts/gpu-stat/ ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress  --include='*.csv' --include='*.txt' --exclude='*' 158:~/.dotfiles/scripts/gpu-stat/ ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress  --include='*.csv' --include='*.txt' --exclude='*' 170:~/.dotfiles/scripts/gpu-stat/ ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress  --include='*.csv' --include='*.txt' --exclude='*' 187:~/.dotfiles/scripts/gpu-stat/ ~/.dotfiles/scripts/gpu-stat/
```

Run `streamlit run main.py --server.port 8080`.

## Disk
Logging disk usage every 5 hour

using `sudo crontab -e`
```
0 */5 * * * /home/emrys/.dotfiles/scripts/gpu-stat/log_disk_usage.bash /home/ /data/ /mnt/*
```

