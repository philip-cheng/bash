#! /bin/bash

# Installing a .dmg application from the command line
# http://commandlinemac.blogspot.co.id/2008/12/installing-dmg-application-from-command.html

app_pkg = app.pkg
app_dmg = app.dmg
app_app = app.app
app_displayname = app.displayname

# Step 1 - Mount the disk image
hdiutil mount "$app_dmg"

# Step 2 - Install the application
# App type: .app
sudo cp -R "/Volumes/$app_displayname/$app_app" /Applications

# App type: .pkg
sudo installer -package "$app_pkg" -target "/Volumes/Macintosh HD"
sudo installer -store -pkg "$app_name" -target /

# Step 3 - Unmount the disk image
cd ~
hdiutil unmount "/Volumes/$app_displayname/"
