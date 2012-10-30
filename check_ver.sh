#!/bin/bash 
if [ "$(uname -s)" == 'FreeBSD' ]; then
  OS='freebsd'
elif [ -f "/etc/redhat-release" ]; then
  RHV=$(egrep -o 'Fedora|CentOS|Red.Hat' /etc/redhat-release)
  case $RHV in
    Fedora)  OS='fedora';;
    CentOS)  OS='centos';;
   Red.Hat)  OS='redhat';;
  esac
elif [ -f "/etc/debian_version" ]; then
  OS=`echo -n Debian Version: && cat /etc/debian_version`
  
fi

echo "$OS"

uname -a

# adrese ip
ifconfig | awk 'BEGIN { FS = "\n"; RS = "" } { print $1 $2 }' | sed -e 's/ .*inet addr:/,/' -e 's/ .*//'


# nume servicii
netstat -lp | cut -f2 -d'/' | awk '{print $1}'|grep -v -E '(avahi|Active|0|Program|getnameinfo failed)' | sort | uniq
