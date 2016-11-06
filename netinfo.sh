#!/bin/bash
clear
echo -e "\n\t\t credits:MVN  "
sleep 0.5
clear
geoiplookup 0.0.0.0
if(( $? ))
then
clear
echo " 'geoip' is required for FULL functionality ."
sleep 0.3
echo " installing geoip !"

sudo apt-get install geoip-bin
fi
clear
read -p "Enter url(www.*.com) or ip:" url
if(( 0 < $(echo $url | cut -c1 ) ))
then
ip=$url
else
purl=$( echo $url | cut -f2- -d"." )
echo "Checking $purl"
i=0
ping -c 1 $purl 
if(( $? ))
then
	i=1
	mpurl=$(echo $purl | rev | cut -c2- | rev )
	echo "trying $mpurl"
	ping -c 1 $mpurl
	if(( $? ))
	then
		echo " $url is DOWN ! try after sometime"
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
echo -e "\n\tURL:$url\n"
echo -e "\tIP:$ip\n"

echo -e "\tServer Loaction:$(geoiplookup $ip | head -1 | cut -f2 -d':' )\n"
echo "Scanning Open Ports and OS in server:"
AvaPorts=$(sudo nmap -O $ip | sed -e '1,5d' | head -n -2  )
echo -e "\n$AvaPorts"

