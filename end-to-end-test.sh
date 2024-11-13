#!/bin/bash

set -e

FLOATING_IP=$(openstack floating ip list --status ACTIVE -f value -c "Floating IP Address" | head -n 1)

if curl -s "http://$FLOATING_IP" | grep -q "Apache2 Ubuntu Default Page"; then
  echo "End-to-end test passed - Application is accessible"
else
  echo "End-to-end test failed - Application is not accessible"
  exit 1
fi

