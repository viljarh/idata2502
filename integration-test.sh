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

FLOATING_IP=$(openstack floating ip list --status ACTIVE -f value -c "Floating IP Address" | head -n 1)

if ping -c 4 "$FLOATING_IP" >/dev/null 2>&1; then
  echo "Network connectivity test passed"
else
  echo "Network connectivity test failed"
  exit 1
fi


