#this script gets the IP Addresses in a Group
#usage
#sh get_group_ip_address.sh yourgrouphere

curl -k -v --user $NSXUSER:$NSXPASS -H "Content-Type: application/json" -X GET https://$NSX/policy/api/v1/infra/domains/default/groups/$1/members/ip-addresses
