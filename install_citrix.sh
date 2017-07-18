#! /bin/bash

##############################
# variant definition
##############################

# .dmg file fullpath
dmg_path="/Users/localsupport/Downloads/CitrixReceiver.dmg"

# .dmg file mounted path
dmg_mntpath="/Volumes/Citrix Receiver"

# .pkg file fullpath
pkg_name="Install Citrix Receiver.pkg"
pkg_path="$dmg_mntpath/$pkg_name"

# .app dir name
app_name="Uninstall Citrix Receiver.app"

# target path to install .pkg using installer
# using / is enough to tell installer to install sw under /Applications
# using /Applications causes error. 
#install_dest="/"

##############################
# Check file existence
# If exists returns 0, else returns 1.
##############################
has_file() {
    if [ ! -e "$1" ]; then
        # echo "$1 NOT FOUND!"
        return 1
    fi
    return 0
}

##############################
# install Citrix
##############################
    
if [ `has_file "$dmg_path"` ]; then
    echo "$dmg_path NOT FOUND!"
    exit 1
fi

echo "Proceeding dmg ..."

# Step 1 - Mount the disk image
hdiutil mount "$dmg_path"

# Step 2 - Install the application
if [ `has_file "/$pkg_path"` ]; then
    echo "/$pkg_path NOT FOUND!"
    exit 1
fi

sudo installer -package "$pkg_path" -target /

sudo cp -R "/$dmg_mntpath/$app_name" /Applications

# Step 3 - Unmount the disk image
#cd ~
hdiutil unmount "$dmg_mntpath"
    
echo "Done with dmg."
exit 0
