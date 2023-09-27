Use `Rsync` to sync the data

Rather Run this in a crontab job by `crontab -e`
Run detection and synchronizaion every 5 mins

```
*/5 * * * * rsync -avz --progress 119:~/G/gpu-stat/172.18.240.119_gpu_log.csv ~/G/gpu-stat/
*/5 * * * * python ~/.dotfiles/scripts/gpu-stat/log_gpu_usage.py
```

For the data server
Run `streamlit run main.py --server.port 8080`
