#!/bin/bash

# Create log file
LOG_FILE=script22.04.log

touch $LOG_FILE


# List of applications to be installed
APPS="quickemu goverlay virt-manager nala"

# List of PPAs to be added
PPAS="ppa:flexiondotorg/quickemu "

# Ask user if they want to install the "lotus' default" set of applications
read -p "Do you want to install the 'lotus' default' set of applications? (y/n) " user_response

# Check user response and act accordingly
if [ "$user_response" == "y" ]; then
    # Add PPAs
    for ppa in $PPAS; do
        add-apt-repository -y $ppa >> $LOG_FILE 2>&1
    done

    # Update package list
    apt update >> $LOG_FILE 2>&1

    # Iterate through each application name and install it
    for app in $APPS; do
        # Use appropriate package manager for the distribution
        if [ "$OS" == "Ubuntu" ]; then
            apt install -y $app >> $LOG_FILE 2>&1
        elif [ "$OS" == "Debian" ]; then
            apt install -y $app >> $LOG_FILE 2>&1
        else
            echo "Unknown Linux distribution" >> $LOG_FILE 2>&1
        fi
    done
else
    echo "Skipping installation of 'lotus' default' set of applications." >> $LOG_FILE 2>&1
fi

echo "Enter a list of apps to install, separated by spaces: "
read -a apps

for app in "${apps[@]}"; do
  sudo apt install -y "$app"
done

# Ask user if they want to Install drivers
read -p "Do you want to isntall drivers for devices? (y/n) " driver_response

# Check user response and act accordingly
if [ "$driver_response" == "y" ]; then 
    #run Ubuntu Driver Manager
    ubuntu-drivers autoinstall
else 
    echo "Skipping driver installation"
fi

# Ask user if they want to configure audio settings
read -p "Do you want to configure audio settings? (y/n) " audio_response

# Check user response and act accordingly
if [ "$audio_response" == "y" ]; then
    # Run the audio configuration script
    ./audio.sh
else
    echo "Skipping audio configuration." >> $LOG_FILE 2>&1
fi
