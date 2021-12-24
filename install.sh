# We wrap this whole script in a function, so that we won't execute
# until the entire script is downloaded.
# That's good because it prevents our output overlapping with curl's.
# It also means that we can't run a partially downloaded script.
# We don't indent because it would be really confusing with the heredocs.
run_it () {
CURRENT=`pwd`

if [ ! -d ~/.config-desktop-home ]; then
    echo "\033[0;32m Enable universe apt-get repo.......\033[0m"
    sudo add-apt-repository universe

    echo "\033[0;32m Updating apt.......\033[0m"
    sudo apt update
    
    echo "\033[0;32m Installing python, git, and open-ssh.......\033[0m"
    sudo apt install -y software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install -y -qq python3.9 python3-pip git git-core openssh-server

    echo "\033[0;32m Updating pip.......\033[0m"
    sudo -H pip install --upgrade pip

    echo "\033[0;32m Installing ansible dependencies.......\033[0m"
    sudo apt install -y build-essential libssl-dev libffi-dev python-dev

    echo "\033[0;32m Installing ansible.......\033[0m"
    sudo -H pip install ansible

    echo "\033[0;32m Clone the ansible installation config.......\033[0m"
    sudo -u `whoami` -H git clone https://github.com/ericjsilva/ansible-desktop-ubuntu.git $HOME/.config-desktop-home
else
    echo "\033[0;32mThe folder ".config-desktop-home" is already installed\033[0m"
fi

cd $HOME/.config-desktop-home

ansible-playbook -i hosts site.yml -c local -K

echo "\033[0;32m Installing additional software.......\033[0m"
sudo apt install software-properties-common apt-transport-https wget 

cd ~
# Install Sublime Text
echo "\033[0;32m Installing Sublime Text.......\033[0m"
sudo snap install sublime-text --classic
sudo ln -s /opt/sublime_text/sublime_text /usr/local/bin/sublime

echo "\033[0;32m Installing VSCode.......\033[0m"
sudo snap install --classic code
echo "\033[0;32m Installing VSCode Extensions.......\033[0m"
code --install-extension ms-python.python
code --install-extension EditorConfig.EditorConfigv
code --install-extension bmewburn.vscode-intelephense-client

echo "\033[0;32m Installing Atom.......\033[0m"
sudo snap install --classic atom
echo "\033[0;32m Installing Atom Packages.......\033[0m"
apm install script
apm install file-icons
apm install pigments
apm install autoclose-html-plus
apm install highlight-selected


echo "\033[0;32m Installing PHP projects.......\033[0m"
# Set symlink to PHP development directory
mkdir $HOME/php-www
sudo ln -s $HOME/php-www /var/www/eaglescout
# Checkout the PHP development project
cd $HOME/php-www
git clone https://github.com/ericjsilva/programming-mb-php.git ./
cd ~

echo "\033[0;32m Installing Python projects.......\033[0m"
# Checkout the Python development project
if [ ! -d $HOME/python ]; then
    mkdir $HOME/python
fi
cd python
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
cd js
git clone https://github.com/ericjsilva/programming-mb-javascript-vuejs.git ./
# Set symlink to vuejs development directory
sudo ln -s $HOME/js /var/www/eaglescout/js-labs

cd ~
echo "\033[0;32m Installation complete.\033[0m"
}

run_it
