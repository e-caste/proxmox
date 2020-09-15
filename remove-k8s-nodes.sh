#!/bin/bash

for node in 1000 1001 1002; do
    qm stop $node
    qm destroy $node
done
