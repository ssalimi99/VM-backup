#!/bin/bash
#
# backupVM.bash
# Purpose: Backup VM images
# USAGE: ./backupVM.bash
#
# Author: Soheil Salimi
# Date: 2024-02-01

user=$(whoami)
if [ $user != "root" ] # only runs if using sudo or root
then 
	echo "You must run this script with root privileges. Please use sudo" >&2
	exit 1
fi

# Set variables for source path and backup path
img_path="/var/lib/libvirt/images/"
backup_path="/home/YOURUSERNAME/backups/"

# prompt if all VMs to be backed-up
read -p "Backup all VMs? (y|n):" answer

# backup all VMs if answer is yes
if [ "$answer" = "y" ]
then
	for num in 1 2 3 # Determinant loop for 3 arguments: 1, 2, and 3
	do 
		vm="deb${num}"
		echo "Backing up VM ${vm}"
		# gzip < ${img_path}${vm}.qcow2 > ${backup_path}${vm}.qcow2.gz
		"gzip < ${img_path}$vm}.qcow2 > ${backup_path}${vm}.qcow2.gz"
		echo "${vm} BACKUP DONE"
	done
# Prompt for VM if answer is no
elif [ "$answer" = "n" ]
then
	read -p "Which VM should be backed up? (1|2|3): " numanswer
	until echo $numasnwer | grep "^[123]$" >> /dev/null # LOoke for math of single digit: 1, 2 or 3
	do
		read -p "Invalid Selection. Select 1, 2, or 3: " numanswer
	done
vm="deb${numanswer}"
echo "Backing up VM ${vm}"
gzip < ${img_path}${vm}.qcow2 > ${backup_path}${vm}.qcow2.gz
echo "${vm} BACKUP DONE"
else
	echo "INvalid Selection... Aborting program"
	exit 2
fi

