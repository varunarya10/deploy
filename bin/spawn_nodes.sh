#!/bin/bash
if [ $# -ne 1 ]
then
    echo "Usage: $0 nodes.yaml"
    exit 1
fi

for node in $(python -c 'import yaml; d = yaml.load(open("'$1'", "r")); print " ".join([x for x in d.keys()])')
do
	bin/spawn_node.sh ${node} &
done
