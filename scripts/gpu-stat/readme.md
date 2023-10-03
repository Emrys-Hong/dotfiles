Run logging and synchronization script in a crontab job by `crontab -e`, every 5 mins

ensure miniconda is installed
```
*/5 * * * * $HOME/miniconda3/bin/python $HOME/.dotfiles/scripts/gpu-stat/log_gpu_usage.py
```
and sometimes need to run this `sudo ip link delete docker0`

On the data server
(Ensure .ssh/config is set and ssh-copy-id have done)
(try `ssh xxx` can run smoothly)
```
*/5 * * * * rsync -avz --progress 119:~/.dotfiles/scripts/gpu-stat/*.csv ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress 107:~/.dotfiles/scripts/gpu-stat/*.csv ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress 195:~/.dotfiles/scripts/gpu-stat/*.csv ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress 100:~/.dotfiles/scripts/gpu-stat/*.csv ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress 231:~/.dotfiles/scripts/gpu-stat/*.csv ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress 158:~/.dotfiles/scripts/gpu-stat/*.csv ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress 170:~/.dotfiles/scripts/gpu-stat/*.csv ~/.dotfiles/scripts/gpu-stat/
*/5 * * * * rsync -avz --progress 81:~/.dotfiles/scripts/gpu-stat/*.csv  ~/.dotfiles/scripts/gpu-stat/
```

Run `streamlit run main.py --server.port 8080` and check result at `http://172.17.240.73:8080`
