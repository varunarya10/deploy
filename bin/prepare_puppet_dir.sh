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

cat "${modulefile}" | while read module
do
    if echo "${module}" | grep -q github.com
    then
        url="$(echo ${module} | cut -f1 -d' ')"
        name="$(echo ${module} | cut -f2 -d' ')"
        git clone "${url}" "${outputdir}/${name}"
    else
        puppet module install --modulepath="${outputdir}" $module
    fi
done
