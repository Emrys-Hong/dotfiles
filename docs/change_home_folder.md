### Define the custom home directory path
ROOT_HOME_PATH="/path/to/set"

### Create the directory and set ownership and permissions
sudo mkdir -p "$ROOT_HOME_PATH"
sudo chown root:root "$ROOT_HOME_PATH"
sudo chmod 700 "$ROOT_HOME_PATH"

### Create the profile script to set root's HOME
sudo tee /etc/profile.d/root-home.sh >/dev/null <<EOF
[ "\$(id -u)" -eq 0 ] || return
export HOME="$ROOT_HOME_PATH"
export INPUTRC="\$HOME/.inputrc"
[ -f "\$HOME/.bashrc" ] && . "\$HOME/.bashrc"
EOF

### Set correct permissions for the profile script
sudo chmod 644 /etc/profile.d/root-home.sh

### Change .bashrc to sudo -i
echo `sudo -i` > ~/.bashrc
