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

    echo "\033[0;32m Updating apt-get.......\033[0m"
    sudo apt-get update

    echo "\033[0;32m Installing python, git, and open-ssh.......\033[0m"
    sudo apt-get install -y -qq python python-pip git git-core openssh-server

    echo "\033[0;32m Updating pip.......\033[0m"
    sudo -H pip install --upgrade pip

    echo "\033[0;32m Installing ansible dependencies.......\033[0m"
    sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev

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
# Install Sublime Text
cd ~
wget https://download.sublimetext.com/sublime-text_build-3176_i386.deb
sudo -H dpkg -i sublime-text_build-3126_i386.deb
sudo ln -s /opt/sublime_text/sublime_text /usr/local/bin/sublime

# Install Meteor
# curl https://install.meteor.com/ | sh

# set symlink to php development directory
mkdir $HOME/php-www
sudo ln -s $HOME/php-www /var/www/eaglescout
# checkout the PHP development project
cd $HOME/php-www
git clone https://github.com/ericjsilva/programming-mb-php.git ./

cd ~
# checkout the Python development project
if [ ! -d $HOME/python ]; then
    mkdir $HOME/python
fi
cd python
git clone https://github.com/ericjsilva/programming-mb-python.git ./
cd ~
# Install pygame
sudo pip install pygame

# checkout the React/Meteor development project
if [ ! -d $HOME/js ]; then
    mkdir $HOME/js
fi
cd js
git clone https://github.com/ericjsilva/programming-mb-javascript.git ./

cd ~

# checkout the VueJS development project
if [ ! -d $HOME/vuejs ]; then
    mkdir $HOME/vuejs
fi
cd vuejs
git clone https://github.com/ericjsilva/programming-mb-javascript-vuejs.git ./
# set symlink to vuejs development directory
sudo ln -s $HOME/vuejs /var/www/eaglescout/vuejs

cd ~
}

run_it
