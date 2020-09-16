#!/bin/bash

source nodes.sh

for node in ${NODES[*]}; do
	qm start $node
done
