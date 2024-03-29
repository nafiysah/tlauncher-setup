#!/bin/bash

# make sure the script is running as root
if [ "$UID" -ne "0" ]; then
	echo "You must root to run $0. Try following"
	echo "sudo $0"
	exit 9
fi

prepare_workdir()
{
	declare dirname=$1

	mkdir -p ${dirname}
	cd ${dirname}
}

delete_workdir()
{
	declare dirname=$1
	rm -rf ${dirname}
}

prepare_minecraft_dirs()
{
	mkdir -p ~/.minecraft/icons
}

prepare_java_installer()
{
	# get install-java.sh script
	wget https://raw.githubusercontent.com/chrishantha/install-java/master/install-java.sh
	
	chmod +x install-java.sh
}

prepare_jdk()
{
	# get JDK 8 from dropbox to avoid signing in to oracle
	wget https://dl.dropboxusercontent.com/s/6jrpd1uxrlhhsni/jdk-8u211-linux-x64.tar.gz
}


install_java()
{
	prepare_java_installer
	prepare_jdk

	mkdir -p /usr/lib/jvm

	# run installer
	yes | sudo -E ./install-java.sh -f jdk-8u211-linux-x64.tar.gz -p /usr/lib/jvm
}

prepare_dependencies()
{
	install_java
}

prepare_tlauncher_jar()
{
	wget -O tl.zip tlauncher.org/jar

	unzip tl.zip '*.jar'
	find . -name "*.jar" -exec chmod +x {} \;
}

prepare_minecraft_icon()
{
	wget -O default.png https://dl.dropboxusercontent.com/s/pht6xgc9631x07d/minecraft.png
}

# move files to minecraft directory
move_files()
{
	# move tlauncher jar
	mv *.jar ~/.minecraft/tlauncher.jar

	# move minecraft icon
	mv default.png ~/.minecraft/icons
}

add_desktop_entry()
{
	wget https://raw.githubusercontent.com/nafiysah/tlauncher-setup/master/minecraft.desktop
	mv minecraft.desktop /usr/share/applications
}

add_command_alias()
{
alias minecraft='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY /usr/bin/java -jar -Dswing.systemlaf=javax.swing.plaf.nimbus.NimbusLookAndFeel ~/.minecraft/tlauncher.jar'
}

init_tlauncher()
{
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY /usr/bin/java -jar -Dswing.systemlaf=javax.swing.plaf.nimbus.NimbusLookAndFeel ~/.minecraft/tlauncher.jar
}
main()
{	
	prepare_workdir ~/solidwaffle
	prepare_minecraft_dirs
	prepare_dependencies
	prepare_tlauncher_jar
	prepare_minecraft_icon
	move_files
	add_desktop_entry
 	add_command_alias
  	init_tlauncher
	delete_workdir ~/solidwaffle

	chmod -R +x ~/.minecraft
}

main
