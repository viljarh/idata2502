#!/bin/bash

set -e

if openstack network show network-viljar >/dev/null 2>&1; then
  echo "Network verification passed"
else
  echo "Network verification failed"
  exit 1
fi

if openstack subnet show my_subnet >/dev/null 2>&1; then
  echo "Subnet verification passed"
else
  echo "Subnet verification failed"
  exit 1
fi

INSTANCE_STATUS=$(openstack server show my_instance --format value --column status)
if [ "$INSTANCE_STATUS" == "ACTIVE" ]; then
  echo "Instance is running - verification passed"
else
  echo "Instance not running - verification failed"
  exit 1
fi
