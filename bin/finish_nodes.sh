#!/bin/bash
if [ $# -ne 3 ]
then
    echo "Usage: $0 environment.yaml encdata.yaml puppetdir"
    exit 1
fi

environment="$1"
encdata="$2"
puppetdir="$3"

for node in $(python -c 'import yaml; d = yaml.load(open("'"${environment}"'", "r")); print " ".join([x["ip"] for x in d.values()])')
do
    cd "${puppetdir}"
	tar cz . | ssh ubuntu@$node 'rm -rf modules || true; mkdir modules ; cd modules ; tar xz'
    cd -
    scp -r data/enc.py ${encdata} ubuntu@$node:
    ssh ubuntu@${node} 'sudo rm -rf /etc/puppet/modules ; \
                        sudo mv modules /etc/puppet/modules ; \
                        sudo mv enc.py /etc/puppet/enc.py ; \
                        sudo chmod +x /etc/puppet/enc.py ; \
                        sudo mv encdata.yaml /etc/puppet/encdata.yaml; \
                        sudo sed -i -e "/^.main.$/anode_terminus=exec\nexternal_nodes=/etc/puppet/enc.py" /etc/puppet/puppet.conf;
                        sudo puppet apply --debug /dev/null'
done
