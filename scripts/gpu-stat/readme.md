Run logging and synchronization script in a crontab job by `crontab -e`, every 5 mins

ensure miniconda is installed
```
*/5 * * * * $HOME/miniconda3/bin/python $HOME/.dotfiles/scripts/gpu-stat/log_gpu_usage.py
```

On the data server
(Ensure .ssh/config is set and ssh-copy-id have done)

```
*/5 * * * * rsync -avz --progress 119:$HOME/.dotfiles/scripts/gpu-stat/172.18.240.119_gpu_log.csv $HOME/.dotfiles/scripts/gpu-stat/
```

Run `streamlit run main.py --server.port 8080`
