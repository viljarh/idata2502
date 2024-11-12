#!/bin/bash

set -e

FLOATING_IP="10.212.25.244"

if ping -c 4 "$FLOATING_IP" >/dev/null 2>&1; then
  echo "Network connectivity test passed"
else
  echo "Network connectivity test failed"
  exit 1
fi


