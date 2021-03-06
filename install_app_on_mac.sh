#! /bin/bash

# Installing a .dmg application from the command line
# http://commandlinemac.blogspot.co.id/2008/12/installing-dmg-application-from-command.html

##############################
# variant definition
##############################

# .dmg file fullpath
dmg_path="/tmp/CitrixReceiver.dmg"

# .dmg file mounted path
dmg_mntpath="/Volumes/Citrix Receiver"

# .app dir name
app_name="Citrix Receiver.app"

# .pkg file fullpath
pkg_path="/tmp/application.pkg"

# application type
apptype="dmg"
#apptype="pkg"

##############################
# Get file extension
##############################
# Extract filename and extension in Bash
# https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
get_ext() {
    fullfile="C:\wk_tmp\abc xyz.1.2.extname.txt"
    filename=$(basename "$fullfile")
    file_ext="${filename##*.}"
    filename="${filename%.*}"
    
    return $file_ext
}

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
# install
##############################
if [ "$apptype" = "dmg" ]; then
    echo "Proceeding dmg ..."
    
    if [ `has_file "$dmg_path"` ]; then
        echo "$dmg_path NOT FOUND!"
        exit 1
    fi

    # Step 1 - Mount the disk image
    hdiutil mount "$dmg_path"

    # Step 2 - Install the application
    if [ `has_file "/$dmg_mntpath/$app_name"` ]; then
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
    if [ `has_file "$pkg_path"` ]; then
        echo "$pkg_path NOT FOUND!"
        exit 1
    fi
    #sudo installer -store -pkg "$app_name" -target /
    sudo installer -package "$pkg_path" -target "/Volumes/Macintosh HD"
    echo "Done with pkg."
    exit 0
else
    echo "Invalid application type: $apptype"
    exit 1
fi
