#!/bin/bash

echo "Creating master node..."
qm clone 9000 1000 --name k8s-master
echo

echo "Creating worker node..."
qm clone 9000 1001 --name k8s-worker-1
echo

echo "Creating worker node..."
qm clone 9000 1002 --name k8s-worker-2
echo

qm start 1000
qm start 1001
qm start 1002
