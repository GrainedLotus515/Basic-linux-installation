#!/bin/bash

# List of applications to be installed
APPS="quickemu goverlay virt-manager nala"

# List of PPAs to be added
PPAS="ppa:flexiondotorg/quickemu ppa:graphics-drivers/ppa"

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
