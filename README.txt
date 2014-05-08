This is the test deployment tool for JioCloud

It consists of a number of tools. Their function and usage syntax is a follows:

  bin/spawn_nodes.sh nodes

    Spawns the nodes and prints a bit of YAML describing the nodes (ip,
    names, uuids)

  bin/prepare_puppet_dir.sh <modulefile> <outputdir>

    Reads <modulefile> which lists the puppet modules and installs them in
    <outputdir>.

  bin/prepare_yaml.py <environment> <nodes>

    Reads an environment description and compiles a node description into a
    config file for the Puppet ENC. More docs on their way. See the tests dir
    for an example.

  bin/finish_nodes.sh <environment> <encdata> <puppetdir>

    Copies puppet modules and encdata to the nodes and performs a puppet run.


  bin/full_deploy.sh <scenario>

    Call all the above scripts.


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

A full example is:
$ bin/full_deploy.sh only-dashboard

That's it. That should deploy a fresh dashboard for you.
