#!/bin/bash
clear

RED='\033[0;31m'
BROW='\033[0;33m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
LRED='\033[1;31m'
LBLUE='\033[1;34m'
BLUE='\033[0;34m'
NM='\033[0;0m'
LGRAY='\033[1;33m'

echo "Few files required to be installed , Enter your password: " 
sudo echo -n " " 
ping -c 1 google.com
if(( !$? ))
then
clear
echo -e "${GREEN}Installing dependency Files !"
sudo apt-get install toilet
sudo apt-get install geoip-bin
sudo apt-get install nmap
else
echo "${LRED}ERROR:CHECK YOUR NETWORK !"
exit 0
fi
clear
toilet -f mono12 -F gay welcome
echo -e "\t\tcredits: ${BLUE} Vamshinath M${WHITE}  "
echo -e -n "Enter url(www.*.com) or ip:${GREEN}" 	
read   url
clear
if(( 0 < $(echo $url | cut -c1 ) ))
then
ip=$url
else
purl=$( echo $url | cut -f2- -d"." )
i=0

clear
ping -c 1 $purl 
if(( $? ))
then
	i=1
	mpurl=$(echo $purl | rev | cut -c2- | rev )
	echo "trying $mpurl"
	ping -c 1 $mpurl
	if(( $? ))
	then
		clear
		echo -e "${GREEN}$url${WHITE} is${LRED} DOWN !${LRED} try after sometime"
		exit 0
	fi
fi
if(( $i == 0 ))
then
ip=$(ping -c 1 $purl | grep "^PING" | cut -f1 -d")" | cut -f2 -d"(" )
else
ip=$(ping -c 1 $mpurl | grep "^PING" | cut -f1 -d")" | cut -f2 -d"(" )
fi
fi
clear
echo -e "\n\t${WHITE}URL:${GREEN}$url\n${WHITE}"
echo -e "\tIP:${BLUE}$ip\n"

echo -e "\t${WHITE}Server Location:${BROW}$(geoiplookup $ip | head -1 | cut -f2 -d':' )\n"
echo -e "${LRED}Scanning Open Ports and OS in server:${NM}"
AvaPorts=$(sudo nmap -O $ip | sed -e '1,5d' | head -n -2 )
echo -e "\n${WHITE}$AvaPorts\n\n"
