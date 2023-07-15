#!/bin/bash

# make sure the script is running as root
if [ "$UID" -ne "0" ]; then
	echo "You must root to run $0. Try following"
	echo "sudo $0"
	exit 9
fi

uninstall_java()
{
  rm -rf /usr/lib/jvm
}

clear_dependencies()
{
  apt-get remove unzip i3-wm lxterminal -y
  uninstall_java
}

clear_minecraft_files()
{
  rm -rf ~/.minecraft /usr/share/applications/minecraft.desktop
}

clear_aliases()
{
  unalias minecraft
}

main()
{	
	clear_dependencies
 	clear_minecraft_files
  	clear_aliases
}

main
