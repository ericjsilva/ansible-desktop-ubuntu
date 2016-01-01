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

    echo "\033[0;32m Installing ansible.......\033[0m"
    sudo pip install ansible

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
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb
sudo dpkg -i sublime-text_build-3083_amd64.deb

# Install Meteor
curl https://install.meteor.com/ | sh

# set symlink to development directory
mkdir $HOME/php-www
sudo ln -s $HOME/php-www /var/www/eaglescout
}

run_it
