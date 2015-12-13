Automated Desktop Setup
=======================

Requirements
-----------

    * curl,
    * git,
    * git-core.

Run
---

If you want to change anything :

```shell
$ curl -L https://raw.githubusercontent.com/ericjsilva/ansible-desktop-ubuntu/master/install.sh | sh
```

And enter your password.

Default installation
--------------------

This project will install the following packages:

    * aptitude
    * bash-completion
    * openssh-server
    * vim
    * git, git-core, git-flow, git-email, git-extras, git-svn
    * zsh
    * curl
    * wget
    * htop
    * ack-grep
    * tmux
    * tig
    * unzip, tar, gzip, bzip2
    * nfs-kernel-server, nfs-common
    * pwgen
    * LAMP (MariaDB), pear, phpmyadmin, Composer
    * MongoDB
    * nodejs
    
Custom installation
-------------------

if you want to customize the installation to suit your needs, you have to clone this repository:

    `$ git clone git@github.com:ericjsilva/ansible-desktop-ubuntu.git`  OR
    `$ git clone https://github.com/ericjsilva/ansible-desktop-ubuntu.git`

And you have to edit the file `site.yml` and comment line the list roles. For example :

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
    - vim       # Configuration for vim
    - apache
    - php
    - mariadb
    - mysql
    - phpadmin
    - mongodb
    - composer
    - nodejs
```

Install Ansible :

    $ sudo apt-get install -y -qq python python-pip
    $ sudo pip install ansible

And execute command :

    $ ansible-playbook -i hosts site.yml -c local -K

You can also contribute to add new roles or improve existing.

License
-------

MIT / BSD