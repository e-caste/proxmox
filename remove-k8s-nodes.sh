#!/bin/bash

source nodes.sh

for node in ${NODES[*]}; do
    qm stop $node
    qm destroy $node
done
