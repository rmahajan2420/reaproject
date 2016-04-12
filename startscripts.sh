#!/bin/bash

PUPPET=/usr/bin/puppet
YUM=/usr/bin/yum
ECHO=/bin/echo
TAR=/bin/tar
CP=/bin/cp
GIT=/usr/bin/git
SED=/bin/sed
AWK=/bin/awk
IFCONFIG=/sbin/ifconfig
MKDIR=/bin/mkdir
WGET=/bin/wget
HEAD=/usr/bin/head
SETENFORCE=/sbin/setenforce

$YUM install  -y wget
$WGET ftp://195.220.108.108/linux/centos/7.1.1503/updates/x86_64/Packages/ruby-devel-2.0.0.598-25.el7_1.x86_64.rpm
$WGET http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
rpm -ivh epel-release-7-5.noarch.rpm
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm


if [ -z `$PUPPET master --version` ]; then
	$YUM install -y puppet-server
fi


$TAR -xvf puppet.tar.gz

$CP -rf puppet /etc/
$MKDIR -p  /etc/facter/facts.d
$ECHO "app=rea" > /etc/facter/facts.d/facts.txt
$ECHO `$IFCONFIG eth0 2>/dev/null|$AWK '/inet/ {print $2}'|$HEAD -1` "puppet" >> /etc/hosts

$SETENFORCE 0

if [ ! -f /var/run/puppet/master.pid ]; then
	service puppetmaster start
fi

