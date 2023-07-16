# tlauncher-setup

## Intro 
Scripts to install TLauncher on Lubuntu. 

This is designed to run on the current LTS version of Lubuntu running on a 64GB Sandisk USB. 

As of 2023-07-14,  the current Lubuntu LTS version is 22.04.

## Installation
### Automatic 
- `apt-get install unzip i3-wm lxterminal`
- `sudo chmod +x tl-setup.sh`
- run `sudo ./tl-setup.sh`

### Manual
If there are problems running the script, then here is the manual process of installation.

#### Create a Temporary Work Directory
- `mkdir solidwaffle`
- `cd solidwaffle`

#### Prepare Minecraft Directories
- `mkdir -p ~/.minecraft/icons`

#### Prepare Java Installer
- `wget https://raw.githubusercontent.com/chrishantha/install-java/master/install-java.sh`
- `sudo chmod +x install-java.sh`

#### Prepare JDK
- `wget https://dl.dropboxusercontent.com/s/6jrpd1uxrlhhsni/jdk-8u211-linux-x64.tar.gz`

#### Install Java
- `mkdir -p /usr/lib/jvm`
- `yes | sudo -E ./install-java.sh -f jdk-8u211-linux-x64.tar.gz -p /usr/lib/jvm`

#### Prepare TLauncher .jar
- `wget -O tl.zip tlauncher.org/jar`
- `unzip tl.zip '*.jar'`
- `find . -name "*.jar" -exec chmod +x {} \;`

#### Prepare Minecraft Icon
- `wget -O default.png https://dl.dropboxusercontent.com/s/pht6xgc9631x07d/minecraft.png`

#### Move Files
- `mv *.jar ~/.minecraft/tlauncher.jar`
- `mv default.png ~/.minecraft/icons`

#### Prepare Desktop Icon 
- `wget https://raw.githubusercontent.com/nafiysah/tlauncher-setup/master/minecraft.desktop`
- `mv minecraft.desktop /usr/share/applications`
  
## Uninstall

- `sudo chmod +x tl-uninstall.sh`
- run `sudo ./tl-uninstall.sh`
