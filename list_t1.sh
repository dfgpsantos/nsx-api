curl -k -s --user $NSXUSER:$NSXPASS \
-H "Content-Type: application/json" \
-X GET https://$NSX/policy/api/v1/infra/tier-1s \
| grep '"display_name"\|"tier0_path"\|"route_advertisement_types"'
