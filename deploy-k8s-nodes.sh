#!/bin/bash

source nodes.sh

for node in ${NODES[*]}; do
	qm clone $VM_TEMPLATE_ID $node --name k8s-$node
	qm start $node
done
