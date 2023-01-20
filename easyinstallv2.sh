#!/bin/bash

# Create log file
LOG_FILE=./script.log
touch $LOG_FILE

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

# Run specific script based on distribution
case "$OS" in
    "Ubuntu")
        if [ "$VER" == "22.04" ]; then
            # Run script for Ubuntu 22.04 and redirect output to log file
            ./ubuntu-22.04-script.sh >> $LOG_FILE 2>&1
        elif [ "$VER" == "20.04" ]; then
            # Run script for Ubuntu 20.04 and redirect output to log file
            ./ubuntu-20.04-script.sh >> $LOG_FILE 2>&1
        else
            echo "Unknown version of Ubuntu" >> $LOG_FILE 2>&1
        fi
        ;;
    "Debian")
        if [ "$VER" == "10" ]; then
            # Run script for Debian 10 and redirect output to log file
            ./debian-10-script.sh >> $LOG_FILE 2>&1
        elif [ "$VER" == "11" ]; then
            # Run script for Debian 11 and redirect output to log file
            ./debian-11-script.sh >> $LOG_FILE 2>&1
        else
            echo "Unknown version of Debian" >> $LOG_FILE 2>&1
        fi
        ;;
    *)
        echo "Unknown Linux distribution" >> $LOG_FILE 2>&1
        ;;
esac
