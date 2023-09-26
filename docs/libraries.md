## Configurations
- Tmux related: [[tmux markdown]](./tmux.md) [[tmux.conf]](./tmux.conf.md)
- Bashrc related: [[bashrc]](./bashrc.md) for linux, [[bash_common]](./bash_common.md) for linux and mac, [[bash_profile]](../bash_profile) for mac, [[inputrc]](../inputrc) for mac and linux to control input behavior
- Git settings: [[gitconfig]](../gitconfig), [[gitignore_global]](../gitignore_global), [[gitattributes_global]](gitattributes_global)
- Conda settings: [[condarc]](../condarc)


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
