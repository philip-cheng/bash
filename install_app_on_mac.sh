#! /bin/bash

# Installing a .dmg application from the command line
# http://commandlinemac.blogspot.co.id/2008/12/installing-dmg-application-from-command.html

##############################
# variant definition
##############################

# .dmg file fullpath
dmg_path="/tmp/cotvnc-20b4.dmg"

# .dmg file mounted path
dmg_mntpath="/Volumes/Chicken of the VNC"

# .app filename
app_name="Chicken of the VNC.app"

# .pkg file fullpath
pkg_path="/tmp/application.pkg"

# application type
apptype="dmg"
#apptype="pkg"

##############################
# has_file()
##############################
has_file() {
    if [ -e "$1" ]; then
        echo "$1 NOT FOUND!"
        return 1
    fi
    return 0
}

##############################
# install
##############################
if [ "$apptype" = "dmg" ]; then
    echo "Proceeding dmg ..."
    
    if [ ! -e "$dmg_path" ]; then
        echo "$dmg_path NOT FOUND!"
        exit 1
    fi

    # Step 1 - Mount the disk image
    hdiutil mount "$dmg_path"

    # Step 2 - Install the application
    if [ ! -e "/$dmg_mntpath/$app_name" ]; then
        echo "/$dmg_mntpath/$app_name NOT FOUND!"
        exit 1
    fi
    sudo cp -R "/$dmg_mntpath/$app_name" /Applications

    # Step 3 - Unmount the disk image
    cd ~
    hdiutil unmount "/$dmg_mntpath/"
    
    echo "Done with dmg."
    exit 0
elif [ "$apptype" = "pkg" ]; then
    echo "Proceeding pkg ..."
    #sudo installer -store -pkg "$app_name" -target /
    sudo installer -package "$pkg_path" -target "/Volumes/Macintosh HD"
    echo "Done with pkg."
    exit 0
else
    echo "Invalid application type!"
    exit 1
fi
