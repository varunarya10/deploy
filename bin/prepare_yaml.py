#!/usr/bin/python

import os
import sys
import yaml

if len(sys.argv) != 3:
	print('Usage: %s <environment.yaml> <nodes.yaml>')
	sys.exit(1)

basedir = os.environ.get('BASEDIR', os.getcwd())

environment_info = yaml.load(open(sys.argv[1], 'r'))

replacements = {}
for node in environment_info.keys():
    for key, val in environment_info[node].iteritems():
        replacements['%s:%s' % (node, key)] = val

input = yaml.load(open(sys.argv[2], 'r'))

output = {}

def do_repl(s):
    if s is None:
        return
    for r in replacements:
        s = s.replace('{%s}' % (r,), replacements[r])
    return s

def repl(d):
    for k, v in d.iteritems():
        if getattr(v, 'iteritems', False):
            d[k] = repl(v)
        elif isinstance(v, list):
           d[k] = [do_repl(x) for x in v]
        else:
           d[k] = do_repl(v)
    return d

output = repl(input)
print yaml.dump(dict([(environment_info[k]['name'], v) for k,v in output.iteritems()]), default_flow_style=False)
