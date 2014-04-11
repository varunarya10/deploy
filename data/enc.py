#!/usr/bin/python
import sys
import yaml

data = yaml.load(open(sys.argv[1], 'r'))
print yaml.dump(data[sys.argv[2]], default_flow_style=False)
