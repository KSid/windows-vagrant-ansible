#!/bin/bash

ANSIBLE_DIR=$1
ANSIBLE_PLAYBOOK=$2
ANSIBLE_HOSTS=$3
TEMP_HOSTS="/tmp/ansible_hosts"

if [ ! -f /vagrant/$ANSIBLE_PLAYBOOK ]; then
	echo "Cannot find Ansible playbook"
	exit 1
fi

if [ ! -f /vagrant/$ANSIBLE_HOSTS ]; then
	echo "Cannot find Ansible hosts"
	exit 2
fi

if [ ! -d $ANSIBLE_DIR ]; then
	echo "Updating apt cache"
	apt-get update
	echo "Installing Ansible dependencies and Git"
	apt-get install -y git python-yaml python-paramiko python-jinja2
	echo "Cloning Ansible"
	git clone git://github.com/ansible/ansible.git ${ANSIBLE_DIR}
fi

cd ${ANSIBLE_DIR}
cp /vagrant/${ANSIBLE_HOSTS} ${TEMP_HOSTS} && chmod -x ${TEMP_HOSTS}
echo "Running Ansible"
bash -c "source hacking/env-setup && ansible-playbook /vagrant/${ANSIBLE_PLAYBOOK} --inventory-file=${TEMP_HOSTS} --connection=local"
rm ${TEMP_HOSTS}
