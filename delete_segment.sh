#!/bin/bash

echo "Do you realy want to DELETE segment $1"
read -p "Y/N" -n 1 -r CHOICE

if [[ $CHOICE =~ ^[Yy]$ ]]

then

curl -k -v --user $NSXUSER:$NSXPASS \
-H "Content-Type: application/json" \
-X DELETE https://$NSX/policy/api/v1/infra/segments/$1

else

echo ""
echo "Segment $1 shall not be deleted!"

fi
