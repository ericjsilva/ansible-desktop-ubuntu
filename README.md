# Automated Desktop Setup

This is an ansible script designed to automate the installation of an Ubuntu desktop complete with the basic tools and services needed to develop applications in PHP, Python, and JavaScript.

## Compatibility

This script has been tested on the following Ubuntu versions:

    * 20.04 LTS

## Requirements

    * curl
    * git
    * git-core

## Run

If you want to change anything:

```shell
$ curl -L https://raw.githubusercontent.com/ericjsilva/ansible-desktop-ubuntu/master/install.sh | sh
```

And enter your password _(if prompted)_.

## Default Installation

This project will install the following packages:

    * aptitude
    * bash-completion
    * openssh-server
    * vim
    * git
    * git-core
    * git-flow
    * git-email
    * git-extras
    * git-svn
    * zsh
    * curl
    * wget
    * htop
    * ack-grep
    * ccze
    * tmux
    * terminator
    * tig
    * unzip
    * tar
    * gzip
    * bzip2
    * nfs-kernel-server
    * nfs-common
    * pwgen
    * imagemagick
    * LAMP (MariaDB), pear, phpmyadmin, Composer
    * MongoDB
    * nodejs

## Custom Installation

if you want to customize the installation to suit your needs, you have to clone this repository:

`$ git clone git@github.com:ericjsilva/ansible-desktop-ubuntu.git`  OR
`$ git clone https://github.com/ericjsilva/ansible-desktop-ubuntu.git`

And you have to edit the file `site.yml` and comment line the list roles. For example:

```yml
##
# Ansible playbook for setting up a LAMP development server on Ubuntu 14.04.
#

---
- hosts: local
  user: bsa_user
  sudo: yes

  vars_files:
    - group_vars/all.yml

  roles:
    - common    # List of essential packages
    - apache
    - php
    - mariadb
    - mysql
    - phpmyadmin
    - mongodb
    - composer
    - nodejs
```

Install Ansible:

    $ sudo apt-get install -y -qq python python-pip
    $ sudo pip install ansible

And execute command:

    $ ansible-playbook -i hosts site.yml -c local -K

You can also contribute to add new roles or improve existing.

## License

MIT. See LICENSE.
