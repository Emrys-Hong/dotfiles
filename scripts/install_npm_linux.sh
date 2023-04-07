read -p "Install nodejs? y or n?" npm
if [ "$npm" == "y" ]; then
    mkdir ~/nodejs-latest
    cd ~/nodejs-latest
    wget -c https://nodejs.org/dist/v12.18.0/node-v12.18.0-linux-x64.tar.xz  -O node-latest.tar.xz
    tar -xvf node-latest.tar.xz --strip-components=1 
    export NODE_HOME=~/nodejs-latest
    export PATH=$NODE_HOME/bin:$PATH
    npm install -g pyright
    npm install -g prettier
fi
echo "export NODE_HOME=~/nodejs-latest" >> ~/.bash_local
echo 'export PATH=$NODE_HOME/bin:$PATH' >> ~/.bash_local
