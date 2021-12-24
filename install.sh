# We wrap this whole script in a function, so that we won't execute
# until the entire script is downloaded.
# That's good because it prevents our output overlapping with curl's.
# It also means that we can't run a partially downloaded script.
# We don't indent because it would be really confusing with the heredocs.
run_it () {
CURRENT=`pwd`

if [ ! -d ~/.config-desktop-home ]; then
    echo "\033[0;32m Enable universe apt repo.......\033[0m"
    sudo add-apt-repository universe

    echo "\033[0;32m Enable ondrej/php apt repo.......\033[0m"
    sudo add-apt-repository -y --update ppa:ondrej/php

    echo "\033[0;32m Updating apt.......\033[0m"
    sudo apt update
    sudo apt install -y software-properties-common
    
    echo "\033[0;32m Installing python, git, and open-ssh.......\033[0m"
    sudo add-apt-repository -y --update ppa:deadsnakes/ppa
    sudo apt install -y -qq python3.9 python3-pip git git-core openssh-server

    echo "\033[0;32m Updating pip.......\033[0m"
    pip install --upgrade pip

    echo "\033[0;32m Installing ansible.......\033[0m"
    sudo add-apt-repository -y --update ppa:ansible/ansible
    sudo apt install ansible

    echo "\033[0;32m Clone the ansible installation config.......\033[0m"
    sudo -u `whoami` -H git clone https://github.com/ericjsilva/ansible-desktop-ubuntu.git $HOME/.config-desktop-home
else
    echo "\033[0;32mThe folder ".config-desktop-home" is already installed\033[0m"
fi

cd $HOME/.config-desktop-home

echo "\033[0;32m Downloading ansible roles.......\033[0m"
ansible-galaxy install adriagalin.timezone
ansible-galaxy install geerlingguy.ntp
ansible-galaxy install geerlingguy.apache
ansible-galaxy install geerlingguy.php
ansible-galaxy install geerlingguy.mysql
ansible-galaxy install geerlingguy.apache-php-fpm
ansible-galaxy install geerlingguy.php-mysql
ansible-galaxy install geerlingguy.phpmyadmin
ansible-galaxy install geerlingguy.composer
ansible-galaxy install geerlingguy.nodejs

echo "\033[0;32m Running ansible playbook.......\033[0m"
ansible-playbook -i hosts site.yml -c local -K

echo "\033[0;32m Installing additional software.......\033[0m"
sudo apt install apt-transport-https

cd ~
# Install Sublime Text
echo "\033[0;32m Installing Sublime Text.......\033[0m"
sudo snap install --classic sublime-text 
sudo ln -s /snap/sublime-text/current/opt/sublime_text/sublime_text /usr/local/bin/sublime

echo "\033[0;32m Installing VSCode.......\033[0m"
sudo snap install --classic code
echo "\033[0;32m Installing VSCode Extensions.......\033[0m"
code --install-extension ms-python.python
code --install-extension EditorConfig.EditorConfig
code --install-extension bmewburn.vscode-intelephense-client

echo "\033[0;32m Installing Atom.......\033[0m"
sudo snap install --classic atom
echo "\033[0;32m Installing Atom Packages.......\033[0m"
apm install script
apm install file-icons
apm install pigments
apm install autoclose-html-plus
apm install highlight-selected
apm install open-in-browser


echo "\033[0;32m Installing PHP projects.......\033[0m"
if [ ! -d $HOME/php ]; then
    mkdir $HOME/php
fi
sudo ln -s $HOME/php /var/www/eaglescout/php
# Checkout the PHP development project
cd $HOME/php
git clone https://github.com/ericjsilva/programming-mb-php.git ./
cd ~

echo "\033[0;32m Installing Python projects.......\033[0m"
# Checkout the Python development project
if [ ! -d $HOME/python ]; then
    mkdir $HOME/python
fi
cd $HOME/python
git clone https://github.com/ericjsilva/programming-mb-python.git ./
# Install 
echo "\033[0;32m Installing Python project dependencies.......\033[0m"
pip install -r requirements.txt
cd ~

echo "\033[0;32m Installing JavaScript projects.......\033[0m"
# Checkout the JavaScript and vue.js development project
if [ ! -d $HOME/js ]; then
    mkdir $HOME/js
fi
sudo ln -s $HOME/js /var/www/eaglescout/js
cd $HOME/js
git clone https://github.com/ericjsilva/programming-mb-javascript-vuejs.git ./

cd ~
echo "\033[0;32m Installation complete.\033[0m"
}

run_it
