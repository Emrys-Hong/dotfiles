## Configurations
- Tmux related: [tmux markdown](./tmux.md) [tmux.conf](../tmux.conf)
- Bashrc related: [bashrc](./bashrc.md) and [bash_common](./bash_common.md)


## Jupyter notebook related
Enable install jupyter notebook extension
```
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
```

Enable Jupyter Notebook passwordless login (not recommend)
```
python scripts/jupyter_without_password_setup.py
```

### Mac packages

Bash completion
```
brew install bash-completion
```
