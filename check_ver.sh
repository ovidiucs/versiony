#!/bin/bash  -x
if [ "$(uname -s)" -eq 'FreeBSD' ]; then
  OS='freebsd'
elif [ -f "/etc/redhat-release" ]; then
  RHV=$(egrep -o 'Fedora|CentOS|Red.Hat' /etc/redhat-release)
  VER=$(awk "{print $2}" /etc/redhat-release)
  case $RHV in
    Fedora)  OS='fedora';;
    CentOS)  OS='centos';;
   Red.Hat)  OS='redhat';;
  esac
elif [ -f "/etc/debian_version" ]; then
  VER=$(awk "{print $1}" /etc/debian_version)
  OS=`echo -n 'Debian'`
fi

uname -a
i=0
# adrese ip
# ifconfig | awk 'BEGIN { FS = "\n"; RS = "" } { print $1 $2 }' | sed -e 's/ .*inet addr:/,/' -e 's/ .*//'
while true
do
 ifconfig eth$i|grep "inet addr:"|awk '{print $2}'|awk -F : '{print $2}'
 if [ $? -ne 0 ]
  then
   i=$(($i+1))
 else
  break 
 fi
done



# nume servicii
netstat -lp | cut -f2 -d'/' | awk '{print $1}'|grep -v -E '(avahi|Active|0|Program|getnameinfo failed)' | sort | uniq

# Format
alias="ABCOMUPTER"
host="abccomputer.internal"
ip="127.0.0.1"
eth0="192.168.1.1"
eth1="172.16.20.25"
serv="http"
verz="2.2.4"

_csvout() {
cat > system.csv << EOF
Alias,Host,IP,OS Ver
$alias,$host,$ip,$OS $VER
Iface,,,
eth0,,$eth0,
eth1,,$eth1,
Service,,,
$serv,$verz,,
EOF
  exit 1
  }
  _csvout
