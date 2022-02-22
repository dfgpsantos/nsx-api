#!/bin/bash


#
#Usage
#
#sh create_t1.sh t1name t0gateway
#Example
#sh create_t1.sh test-t1 T0-GW


if [[ -z $1 ]]
then
echo "You must specify the T1's name eg. 'sh create_t1.sh t1-test'"
exit 0
fi

echo "Do you want to redistribute the following Routes to T0"
echo ""
read -p "TIER1_CONNECTED - Y/N " -n 1 -r CONNECTED
echo ""
read -p "TIER1_STATIC_ROUTES - Y/N " -n 1 -r STATIC
echo ""
read -p "TIER1_NAT - Y/N " -n 1 -r NAT
echo ""
read -p "TIER1_IPSEC_LOCAL_ENDPOINT - Y/N " -n 1 -r IPSEC
echo ""
read -p "TIER1_LB_VIP - Y/N " -n 1 -r LBVIP
echo ""
read -p "TIER1_DNS_FORWARDER_IP - Y/N " -n 1 -r DNSIP
echo ""




CTR=0

if [[ $STATIC =~ ^[Yy]$ ]]
then
ARRAY[$CTR]=' "TIER1_STATIC_ROUTES"'
CTR=$(( $CTR + 1))
fi


if [[ $DNSIP =~ ^[Yy]$ ]]
then
ARRAY[$CTR]=' "TIER1_DNS_FORWARDER_IP"'
CTR=$(( $CTR + 1))
fi

if [[ $NAT =~ ^[Yy]$ ]]
then
ARRAY[$CTR]=' "TIER1_NAT"'
CTR=$(( $CTR + 1))
fi


if [[ $CONNECTED =~ ^[Yy]$ ]]
then
ARRAY[$CTR]=' "TIER1_CONNECTED"'
CTR=$(( $CTR + 1))
fi

if [[ $IPSEC =~ ^[Yy]$ ]]
then
ARRAY[$CTR]=' "TIER1_IPSEC_LOCAL_ENDPOINT"'
CTR=$(( $CTR + 1))
fi


if [[ $LBVIP =~ ^[Yy]$ ]]
then
ARRAY[$CTR]=' "TIER1_LB_VIP"'
CTR=$(( $CTR + 1))
fi

IFS=",$IFS"

ROUTES=`echo "${ARRAY[*]}"`




if [[ -n $2 ]]
then
cat > t1.txt << EOL
{
  "tier0_path":  "/infra/tier-0s/$2",
  "route_advertisement_types": [$ROUTES ]
}
EOL


else
cat > t1.txt << EOL
{
  "route_advertisement_types": [$ROUTES ]
}
EOL

fi

curl -k -s --user $NSXUSER:$NSXPASS \
-H "Content-Type: application/json" \
-X PATCH https://$NSX/policy/api/v1/infra/tier-1s/$1 \
-d @t1.txt

rm t1.txt
