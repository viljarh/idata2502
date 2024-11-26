#!/bin/bash

set -e

# Export OpenStack credentials from environment variables
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

# Fetch the floating IP
FLOATING_IP=$(openstack floating ip list --status ACTIVE -f value -c "Floating IP Address" | head -n 1)

# Perform a simple end-to-end check
if curl -s "http://$FLOATING_IP" | grep -q "ToDo App"; then
  echo "End-to-end test passed - Application is accessible"
else
  echo "End-to-end test failed - Application is not accessible"
  exit 1
fi

