#!/bin/bash
# 
# Termux <-> PRoot SAF Bridge Remover
# Created by heavylildude
# 
# This script scrubs the reverse bind-mount alias from your ~/.bashrc 
# and optionally nukes the shared workspace folder. 

echo -e "\nTime to pack up the board and head home..."
echo -e "Let's scrub this bridge out of your system.\n"

# 1. Gather the intel for the alias
read -p "Enter the PRoot distro name you want to unlink (Default: ubuntu): " DISTRO
DISTRO=${DISTRO:-ubuntu}
ALIAS_NAME="surf-$DISTRO"

# 2. Surgical scrub of the ~/.bashrc
echo -e "\n[*] Scrubbing the '$ALIAS_NAME' alias from your ~/.bashrc..."
sed -i "/alias $ALIAS_NAME=/d" ~/.bashrc
echo "[-] Alias totally wiped."

# 3. The Danger Zone (Folder Deletion)
echo -e "\nWARNING: Do you want to delete the shared workspace folder?"
echo -e "This will VAPORIZE all your code, projects, and node_modules inside it."
read -p "Nuke the folder? (y/N): " NUKE_CHOICE

if [[ "$NUKE_CHOICE" == "y" || "$NUKE_CHOICE" == "Y" ]]; then
    read -p "Enter the exact name of the folder to nuke (Default: DevWorkspace): " FOLDER
    FOLDER=${FOLDER:-DevWorkspace}
    
    if [ -d ~/"$FOLDER" ]; then
        echo "[*] Nuking ~/$FOLDER from orbit..."
        rm -rf ~/"$FOLDER"
        echo "[-] Folder vaporized. Nothing but digital dust left."
    else
        echo "[-] D'oh! Folder ~/$FOLDER doesn't exist. Skipping."
    fi
else
    echo "[-] Safe call, mate. Leaving your files untouched."
fi

# 4. The Exit
echo -e "\nThe bridge has been demolished."
echo -e "Run this command to refresh your current terminal:"
echo -e "source ~/.bashrc\n"
