#!/bin/bash
# 
# Termux <-> PRoot SAF Bridge
# Created by heavylildude
# 
# This script carves out a shared workspace folder in plain Termux and 
# creates a reverse bind-mount alias. This lets you use native Android apps 
# (like Acode or Material Files) to edit code, while your PRoot Linux container 
# handles all the heavy lifting (like npm installs) without Android's FAT32 
# file system shitting the bed over Linux symlinks.

echo -e "\nWelcome to the Termux SAF Bridge Setup..."
echo -e "Let's wax this board and get your workspace dialed in.\n"

# 1. Gather the intel
read -p "Enter the name for your shared folder (Default: DevWorkspace): " FOLDER
FOLDER=${FOLDER:-DevWorkspace}

read -p "Enter your installed PRoot distro name (Default: ubuntu): " DISTRO
DISTRO=${DISTRO:-ubuntu}

read -p "Enter your PRoot Linux username (Default: root): " PROOT_USER
PROOT_USER=${PROOT_USER:-root}

# 2. Map the landing zone
if [ "$PROOT_USER" == "root" ]; then
    PROOT_HOME="/root"
else
    PROOT_HOME="/home/$PROOT_USER"
fi

# 3. Create the master folder in Termux
echo -e "\n[*] Carving out ~/$FOLDER in plain Termux..."
mkdir -p ~/$FOLDER

# 4. Rig the alias
ALIAS_NAME="surf-$DISTRO"
ALIAS_CMD="proot-distro login --user $PROOT_USER --bind ~/$FOLDER:$PROOT_HOME/$FOLDER $DISTRO"

echo "[*] Injecting the alias '$ALIAS_NAME' into your ~/.bashrc..."

# Nuke the old alias if they are re-running the script so it doesn't get bogus
sed -i "/alias $ALIAS_NAME=/d" ~/.bashrc

# Append the new gnarly alias
echo "alias $ALIAS_NAME='$ALIAS_CMD'" >> ~/.bashrc

# 5. The gnarly exit
echo -e "\nYour bridge is fully rigged."
echo -e "----------------------------------------------------"
echo -e "1. Run this command right now to reload your shell:"
echo -e "   source ~/.bashrc"
echo -e "2. Next time you want to code, just type:"
echo -e "   $ALIAS_NAME"
echo -e "----------------------------------------------------\n"
echo -e "Open Acode/Material Files/or anything that can see termux, select the '$FOLDER' folder via the Termux sidebar, and shred safely, mate!"
