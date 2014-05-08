#!/bin/bash -e
scenario="$1"
scenario_file="scenarios/${scenario}.yaml"

if ! test -f "${scenario_file}"
then
	echo "Scenario ${scenario} not found"
	exit 1
fi

tmpdir="$(mktemp -d)"

bin/spawn_nodes.sh ${scenario_file} > "${tmpdir}/environment.yaml"
bin/prepare_puppet_dir.sh modules "${tmpdir}/puppetdir"
bin/prepare_yaml.py "${tmpdir}/environment.yaml" "${scenario_file}" > "${tmpdir}/encdata.yaml"
bin/finish_nodes.sh "${tmpdir}/environment.yaml" "${tmpdir}/encdata.yaml" "${tmpdir}/puppetdir"

cat "${tmpdir}/environment.yaml"

rm -rf "${tmpdir}"
