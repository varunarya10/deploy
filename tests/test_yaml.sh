#!/bin/bash

BASEDIR=$(pwd)/tests/test_yaml
bin/prepare_yaml.py tests/test_yaml/state/environment tests/test_yaml/nodes > tests/test_yaml/output
diff -u $BASEDIR/output $BASEDIR/expected_output
