#!/bin/bash

Help()
{
   # Display Help
   echo "This shell script prints out IP addresses in specified range."
   echo
   echo "Syntax: ip_gen.sh <first-ip-address> <last-ip-address>"
   echo
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
   esac
done

# convert IP to decimal
ip2dec() {
  set -- ${1//./ }     # split $1 with "." to $1 $2 $3 $4
  declare -i dec       # set integer attribute
  dec=$1*256*256*256+$2*256*256+$3*256+$4
  echo $dec
}

# convert decimal to IP
dec2ip() {
  declare -i ip1 ip2 ip3 ip4
  ip1=$1/256/256/256
  ip2=($1-$ip1*256*256*256)/256/256
  ip3=($1-$ip1*256*256*256-$ip2*256*256)/256
  ip4=$1-$ip1*256*256*256-$ip2*256*256-$ip3*256
  echo $ip1.$ip2.$ip3.$ip4
}

s=$(ip2dec $1)
e=$(ip2dec $2)

for ((i=$s;i<=$e;i++)); do
  dec2ip $i 
done
