CURRENT=`pwd`

if [ ! -d ~/.config-desktop-home]
then
    echo "\033[0;32m Installing python.......\033[0m"
    sudo apt-get install -y -qq python python-pip git git-core openssh-server

    echo "\033[0;32m Installing ansible.......\033[0m"
    sudo pip install ansible

    echo "\033[0;32m Clone the installation config.\033[0m"
    sudo -u `whoami` -H git clone https://github.com/ericjsilva/ansible-desktop-ubuntu.git $HOME/.config-desktop-home
else
    echo "\033[0;32mThe folder ".config-desktop-home" is already installed\033[0m"
fi

cd $HOME/.config-desktop-home

ansible-playbook -i hosts site.yml -c local -K

# Install Sublime Text
ansible-galaxy install -r requirements.txt

