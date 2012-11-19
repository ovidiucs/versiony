#!/bin/bash  -x
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

# Format
alias="ABCOMUPTER"
host="abccomputer.internal"
ip="127.0.0.1"
os="CentOS 5.0.2"
eth0="192.168.1.1"
eth1="172.16.20.25"
serv="http"
ver="2.2.4"

_csvout() {
cat << EOF
Alias,Host,IP,OS Ver
$alias,$host,$ip,$os
Iface,,,
eth0,,$eth0,
eth1,,$eth1,
Service,,,
$serv, $ver,,
EOF
  exit 1
  }
  
  _csvout()
