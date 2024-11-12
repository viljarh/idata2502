#!/bin/bash

set -e

STACK_NAME="my_stack"

echo "Deleting the stack: $STACK_NAME"
openstack stack delete --yes --wait "$STACK_NAME"

if openstack stack show "$STACK_NAME" >/dev/null 2>&1; then
  echo "Cleanup failed - Stack $STACK_NAME still exists"
  exit 1
else
  echo "Cleanup successful - Stack $STACK_NAME deleted"
fi

