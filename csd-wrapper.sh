#!/bin/sh
# Cisco Anyconnect CSD wrapper for OpenConnect
CSTUB="$HOME/.cisco/hostscan/bin/cstub"
ARCH="$(uname -m)"
 
if [[ "$ARCH" == "x86_64" ]]; then
	ARCH="linux_x64"
else
	ARCH="linux"
fi
 
shift
 
URL=
TICKET=
STUB=
GROUP=
CERTHASH=
LANGSELEN=
 
while [ "$1" ]; do
	if [ "$1" == "-ticket" ]; then shift; TICKET=$1; fi
	if [ "$1" == "-stub" ]; then shift; STUB=$1; fi
	if [ "$1" == "-group" ]; then shift; GROUP=$1; fi
	if [ "$1" == "-certhash" ]; then shift; CERTHASH=$1; fi
	if [ "$1" == "-url" ]; then shift; URL=$1; fi
	if [ "$1" == "-langselen" ];then shift; LANGSELEN=$1; fi
shift
done
 
ARGS="-log error -ticket $TICKET -stub $STUB -group $GROUP -host $URL -certhash $CERTHASH"
echo $ARGS
 
if [[ -f $CSTUB && -x $CSTUB ]]; then
	$CSTUB $ARGS
else
	wget -c "https://${CSD_HOSTNAME}/CACHE/sdesktop/hostscan/$ARCH/cstub" -O $CSTUB
	chmod +x $CSTUB
	$CSTUB $ARGS
fi
