##

Sign in to your Linode as root

    {{USERNAME}}@localhost$ ssh root@{{IP4_ADDR}}

## Setup the Server Hostname

Set the Linode hostname

    root@linode$ echo "HOSTNAME={{HOSTNAME}}" >> /etc/sysconfig/network
    root@linode$ hostname {{HOSTNAME}}

Add the IP / hosts to `/etc/hosts`

    root@linode$ {{IP4_ADDR}} {{HOSTNAME}}.r34d.me {{HOSTNAME}}
    root@linode$ {{IP6_ADDR}} {{HOSTNAME}}.r34d.me {{HOSTNAME}}

## Set the Server Timezone to UTC

Set the Linode's time zone. I like to use UTC since servers can be moved and accessed all over the world.

    root@linode$ ln -sf /usr/share/zoneinfo/UTC /etc/localtime

## Get the Package Manager Setup

Run system updates

    root@linode$ yum update

Add EPEL and Remi repos to yum

    root@linode$ wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
    root@linode$ wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    root@linode$ rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

## We Love git

Install the latest version of git

    # Dependencies
    root@linode$ yum install gcc openssl-devel curl-devel expat-devel cpan gettext-devel
    root@linode$ cpan -i ExtUtils::MakeMaker

    root@linode$ wget --output-document=git.tar.gz https://github.com/git/git/archive/v2.0.x.tar.gz
    root@linode$ tar zxf git.tar.gz
    root@linode$ cd git-2.0.0

    root@linode$ NO_TCLTK=1 make prefix=/usr/local all
    root@linode$ make prefix=/usr/local install
    root@linode$ git --version

## Enable `sudo` for `wheel`

Allow `wheel` group to use `sudo`

    root@linode$ vim /etc/sudoers

  - Find and uncomment `# %wheel        ALL=(ALL)       ALL`

## Setup a User Account

Add a user for yourself and give the user sudo access

    root@linode$ adduser -G wheel {{USERNAME}}
    root@linode$ passwd {{USERNAME}}

Return to your localhost

    root@linode$ exit

Copy your SSH keys to your linode

    {{USERNAME}}@localhost$ scp -r ssh-user-dir/ {{USERNAME}}@{{IP4_ADDR}}:~/.ssh
    {{USERNAME}}@{{HOSTNAME}}$ ssh {{USERNAME}}@{{IP4_ADDR}}
    {{USERNAME}}@{{HOSTNAME}}$ .ssh/setup

## Disable root login

    {{USERNAME}}@{{HOSTNAME}}$ sudo vim /etc/ssh/sshd_config

  - Find

        #PermitRootLogin yes

  - Replace with

        PermitRootLogin no

Restart `sshd` so the changes take affect

    {{USERNAME}}@{{HOSTNAME}}$ sudo service sshd restart

## Setup a Firewall

    {{USERNAME}}@{{HOSTNAME}}$ sudo cp linode-setup-iptables.firewall.rules /etc/iptables.firewall.rules
    {{USERNAME}}@{{HOSTNAME}}$ sudo iptables-restore < /etc/iptables.firewall.rules
    # verify the rules
    {{USERNAME}}@{{HOSTNAME}}$ sudo iptables -L
    # save the rules so they persist after a reboot
    {{USERNAME}}@{{HOSTNAME}}$ /sbin/service iptables save
