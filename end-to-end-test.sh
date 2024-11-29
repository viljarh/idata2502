#!/bin/bash

set -e

export OS_AUTH_URL=$OS_AUTH_URL
export OS_USERNAME=$OS_USERNAME
export OS_PASSWORD=$OS_PASSWORD
export OS_PROJECT_NAME=$OS_PROJECT_NAME
export OS_PROJECT_ID=$OS_PROJECT_ID
export OS_USER_DOMAIN_NAME=$OS_USER_DOMAIN_NAME
export OS_PROJECT_DOMAIN_ID=$OS_PROJECT_DOMAIN_ID
export OS_REGION_NAME=$OS_REGION_NAME
export OS_IDENTITY_API_VERSION=$OS_IDENTITY_API_VERSION
export OS_INTERFACE=$OS_INTERFACE

# Fetch IP
FLOATING_IP=$(openstack floating ip list --status ACTIVE -f value -c "Floating IP Address" | head -n 1)
echo "Floating IP fetched: $FLOATING_IP"

ping -c 4 "$FLOATING_IP" || { echo "Ping to $FLOATING_IP failed"; exit 1; }

echo "Testing accessibility of http://$FLOATING_IP:3000"
curl -v "http://$FLOATING_IP:3000" || { echo "End-to-end test failed - Application is not accessible at http://$FLOATING_IP:3000"; exit 1; }

