#!/bin/bash
# This script requires puppet to be installed
if [ $# -ne 2 ]
then
	echo "Usage: $0 modulefile outputdir"
	exit 1
fi

modulefile="$1"
outputdir="$2"

if [ -d "${outputdir}" ]
then
	echo "${outputdir} already exists"
	exit 1
fi

mkdir ${outputdir}
mkdir ${outputdir}/modules
mkdir ${outputdir}/manifests

cat "${modulefile}" | while read module
do
	puppet module install --modulepath="${outputdir}/modules" $module
done
