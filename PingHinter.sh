#!/bin/bash

red="\e[31m"
green="\e[32m"
cyan="\e[36m"
clearcol="\e[0m"

ColorRed(){
	echo -ne $red$1$clearcol
}

ColorGreen(){
	echo -ne $green$1$clearcol
}
ColorCyan(){
	echo -ne $cyan$1$clearcol
}

echo -e "Select one server: \n $(ColorRed '1.') Germany \n $(ColorRed '2.') Germany2 \n $(ColorRed '3.') Turkey \n $(ColorRed '4.') Russia \n $(ColorRed '5.') Serbia \n $(ColorRed '6.') Iran"
read servnum 

#You can comment the line below and uncomment the other one to set a permeanent username
read -p "What is your $(ColorRed 'PingHint') $(ColorCyan 'email')? " username
#username=""

case "$servnum" in
	1| Germany) phuser="phs\\$username"
	;;
	2| Germany2) phuser="phk\\$username"
	;;
	3| Turkey) phuser="pht\\$username"
	;;
	4| Russia) phuser="phr\\$username"
	;;
	5| Serbia) phuser="phe\\$username"
	;;
	6| Iran) phuser="phd\\$username"
	;;
	*) echo "Invalid selection"; exit 1
	;;
esac

#You can comment the line below and uncomment the other one to set a permeanent password
read -p "What is your $(ColorRed 'PingHint') $(ColorGreen 'password')? " -s password
#password=""
echo -e " \n "
echo -e $green "Connecting to" $clearcol
echo "$phuser"
echo -e "\n"

auth_file=$(mktemp)
chmod 600 "$auth_file"

echo "$phuser" > "$auth_file"
echo "$password" >> "$auth_file"


sudo openvpn --config ./PingHint.ovpn --auth-user-pass "$auth_file"

rm -f "$auth_file"
