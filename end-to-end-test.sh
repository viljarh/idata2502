#!/bin/bash

set -e

FLOATING_IP="10.212.25.244"

if curl -s "http://$FLOATING_IP" | grep -q "Apache2 Ubuntu Default Page"; then
  echo "End-to-end test passed - Application is accessible"
else
  echo "End-to-end test failed - Application is not accessible"
  exit 1
fi

