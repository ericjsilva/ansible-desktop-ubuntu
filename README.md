![Build Status](https://github.com/ericjsilva/ansible-desktop-ubuntu/actions/workflows/main.yml/badge.svg)
# Automated Desktop Setup

This is an [Ansible](https://github.com/ansible/ansible) script designed to automate the installation of an Ubuntu desktop; complete with the basic tools and services needed to develop applications in PHP, Python, and JavaScript. This repository can easily be extended to support addtional language frameworks and supporting services, databases, etc.

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

or 

```shell
$ wget -O - https://raw.githubusercontent.com/ericjsilva/ansible-desktop-ubuntu/master/install.sh | sh
```

And enter your password _(if prompted)_.

## Default Installation

This project will install the following packages:

    * aptitude (i.e., apt)
    * openssh-server
    * git
    * git-core
    * git-flow
    * git-email
    * git-extras
    * git-svn
    * zsh
    * curl
    * wget
    * nfs-kernel-server
    * nfs-common

This project will install the following applications:

    * LAMP (MySQL, Apache, PHP 8.1), pear, phpmyadmin, composer
    * python 3.9
    * nodejs 14.x
    * [Sublime Text](https://www.sublimetext.com)
    * [Atom IDE](https://atom.io)
    * [VSCode IDE](https://code.visualstudio.com)

## Custom Installation

if you want to customize the installation to suit your needs, you have to clone this repository:

`$ git clone git@github.com:ericjsilva/ansible-desktop-ubuntu.git`  OR
`$ git clone https://github.com/ericjsilva/ansible-desktop-ubuntu.git`

And you have to edit the file `site.yml` and comment line the list roles. For example:

```yml
##
# Ansible playbook for setting up a LAMP development server on Ubuntu 20.04.
#

---
- hosts: localhost
  connection: local
  user: eaglescout
  become: yes

  vars_files:
    - vars/main.yml

  roles:
    - common
    - adriagalin.timezone
    - geerlingguy.ntp
    - geerlingguy.apache
    - geerlingguy.php
    - geerlingguy.mysql
    - geerlingguy.apache-php-fpm
    - geerlingguy.php-mysql
    - geerlingguy.phpmyadmin
    - geerlingguy.composer
    - geerlingguy.nodejs
```

Install Ansible:

```shell
$ sudo apt install -y -qq python3 python3-pip
$ sudo pip install ansible
```

And execute command:

```shell
$ ansible-playbook -i hosts site.yml -c local -K
```

You can also contribute to add new roles or improve existing roles.

## License

MIT. See LICENSE.
