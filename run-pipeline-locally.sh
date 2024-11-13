#!/bin/bash

# source secrets
source .secrets

echo "Running tests..."
./integration-test.sh || { echo "Integration test faild"; exit 1; }

echo "Deploying stack..."
openstack stack create -t heat.yaml --wait my_stack || { echo "Stack deployment failed..."; exit 1; }

echo "Running end-to-end test..."
./end-to-end-test.sh || { echo "End-to-end test failed"; exit 1; }

echo "Pipeline completed successfully!"
