#!/bin/bash -x

test -f deployrc && . deployrc

if [ -z "$KEYPAIR" ]
then
	echo "No keypair specified"
	exit 1
fi

if [ -z "$OS_AUTH_URL" ]
then
	echo "No auth url specified"
	exit 1
fi

if [ -z "$OS_PASSWORD" ]
then
	echo "No password specified"
	exit 1
fi

if [ -z "$OS_USERNAME" ]
then
	echo "No username specified"
	exit 1
fi

if [ -z "$OS_TENANT_NAME" ]
then
	echo "No tenant name specified"
	exit 1
fi

if [ -z "$IMAGE_ID" ]
then
	echo "No image id specified"
	exit 1
fi

if [ -z "$FLAVOR_ID" ]
then
	echo "No flavor id specified"
	exit 1
fi

export OS_AUTH_URL OS_PASSWORD OS_USERNAME OS_TENANT_NAME OS_REGION_NAME

NAME=foo${RANDOM}

echo "Booting server" >&2
boot_output="$(nova boot --image ${IMAGE_ID} --flavor ${FLAVOR_ID} --key_name ${KEYPAIR} --user-data data/userdata ${NAME})"
uuid="$(echo "${boot_output}" | grep ^..uuid | awk -- '{ print $4 }')"

echo "Waiting for IP to be assigned" >&2

ip=''
while [ -z "$ip" ]
do
	ips="$(nova show ${uuid} | grep ' network ' | cut -f3 -d'|' | sed -e 's/ *//g' | awk -- 'BEGIN { FS="," } { print $1; print $2 }')"
	for x in $ips
	do
		if echo $x | grep -v -q -E '^(10|172\.(1[6-9]|2[0-9]|3[0-2])|192\.168)\.'
		then
			ip="${x}"
			break
		fi
	done
done

echo "IP: ${ip}" >&2

echo "Waiting to be able to log in" >&2
while ! ssh -o StrictHostKeyChecking=no ubuntu@${ip} true
do
	sleep 1
done

echo "${1}:"
echo "  ip: ${ip}"
echo "  name: ${NAME}"
echo "  uuid: ${uuid}"
