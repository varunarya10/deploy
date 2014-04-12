#!/usr/bin/python
import sys
import yaml

data = yaml.load(open('/etc/puppet/encdata.yaml', 'r'))
print yaml.dump(data[sys.argv[1].split('.')[0]], default_flow_style=False)
