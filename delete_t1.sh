#!/bin/bash

if [[ -z $1 ]]
then
echo "You must specify the T1's name eg. 'sh delete_t1.sh t1-test'"
exit 0
fi

echo "Do you realy want to DELETE Tier-1 Gateway $1"
read -p "Y/N" -n 1 -r CHOICE

if [[ $CHOICE =~ ^[Yy]$ ]]

then

curl -k -s --user $NSXUSER:$NSXPASS \
-H "Content-Type: application/json" \
-X DELETE https://$NSX/policy/api/v1/infra/tier-1s/$1

else

echo ""
echo "Tier-1 Gateway $1 shall not be deleted!"

fi
