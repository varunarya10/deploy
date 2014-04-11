This is the test deployment tool for JioCloud

It consists of a number of tools. Their function and usage syntax is a follows:

  bin/prepare_puppet_dir.sh <modulefile> <outputdir>

	Reads <modulefile> which lists the puppet modules and installs them in
	<outputdir>/modules.

  bin/prepare_yaml.py <environment> <nodes>

	Reads an environment description and compiles a node description into a
	config file for the Puppet ENC. More docs on their way. See the tests dir
	for an example.

  bin/spawn_node.sh

	Spawns a single node and prints a bit of YAML suitable for input to
	prepare_yaml.py


The files you need are:

  nodes
	lists the nodes that are needed for a deployment. It can references Puppet
	modules, etc. See Puppet's documentation for external node classifiers for
	a better understanding.


  modules
	Lists all the modules that are needed for the deployment. During the
	compilation stage, all these will be downloaded and installed in a
	directory structure ready to be copied to the test nodes.

  deployrc
    Cloud details

There's a lot more work that could be done here. I just wanted get this up here
quickly so that you can get a rough idea of where this is going.

