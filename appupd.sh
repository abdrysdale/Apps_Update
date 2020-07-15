#!/bin/bash

# Checks for updates for all dir in the Apps/ dir.

backup_file="${HOME}/packages.txt"

# Includes colour output
BLUE='\033[0;34m'
NC='\033[0m' # No colour

# Changes to Apps folder
cd ~/Apps

# Iterates over folders
for i in $(ls -d */);
do
	# Checks for repo updates
	echo -e "${BLUE}${i%%}${NC}";
	cd ${i%%}
	git reset --hard HEAD
	output=$(git pull | wc -l);
	
	# Updates the package if updates are available
	if [ ${output} -ne 1 ];
	then 
		makepkg -crsi;
	fi	

	cd ..
done

pacman -Qq  >> ${backup_file}
