#!/bin/bash

set -e

# Load OpenStack credentials from environment variables
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

# Verify network
if openstack network show network-viljar >/dev/null 2>&1; then
  echo "Network verification passed"
else
  echo "Network 'network-viljar' does not exist - verification failed"
  exit 1
fi

# Verify subnet
if openstack subnet show my_subnet >/dev/null 2>&1; then
  echo "Subnet verification passed"
else
  echo "Subnet 'my_subnet' does not exist - verification failed"
  exit 1
fi

# Verify instance status
INSTANCE_STATUS=$(openstack server show my_instance --format value --column status)
if [ "$INSTANCE_STATUS" == "ACTIVE" ]; then
  echo "Instance is running - verification passed"
else
  echo "Instance is not active (status: $INSTANCE_STATUS) - verification failed"
  exit 1
fi

