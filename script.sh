#!/bin/bash

# Function to check the internet connection
check_internet() {
    # Checks internet connection to google using wget with a single try and 10-second timeout
    wget -q --spider --tries=1 --timeout=10 https://www.google.com
    # Returns the exit status of wget command
    return $?
}

# Call the check_internet function
if ! check_internet; then
    echo "No internet connection. Attempting to authenticate..."

    #Authenticates using LDAP credentials 
    curl --interface eth0 --location-trusted -u ldapid:internettoken "https://internet.iitb.ac.in/login.php" >/dev/null
else
    echo "Internet connection is active."
fi
