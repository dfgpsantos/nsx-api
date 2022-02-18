#create new NSX Segment
#
#Usage:
#
#sh create_segment.sh segmentname
#Example
#sh create_segment.sh web1
#
#sh create_segment.sh segmentname segment-default-gateway
#Example
#sh create_segment.sh web1 172.16.79.1/24
#
#sh create_segment.sh segmentname segment-default-gateway T1-Gateway
#Example
#sh create_segment.sh web1 172.16.79.1/24 T1-BR
#
#
#
#!/bin/bash
if [[ -n $3 ]]
then

cat > segment.txt << EOL
{
  "display_name":"$1",
  "subnets": [
      {
        "gateway_address": "$2"
      }
    ],
    "connectivity_path": "/infra/tier-1s/$3"
}
EOL

else

if [[ -n $2 ]]
then

cat > segment.txt << EOL
{
  "display_name":"$1",
  "subnets": [
      {
        "gateway_address": "$2"
      }
    ]
}
EOL

else

cat > segment.txt << EOL
{
  "display_name":"$1"
}
EOL

fi
fi

curl -k -v --user $NSXUSER:$NSXPASS \
-H "Content-Type: application/json" \
-X PATCH https://$NSX/policy/api/v1/infra/segments/$1 \
-d @segment.txt

rm segment.txt
