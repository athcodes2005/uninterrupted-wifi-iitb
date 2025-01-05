#!/bin/bash

# Function to check the internet connection
check_internet() {
    # Checks internet connection to google using wget with a single try and 3-second timeout
    wget -4 -q --spider --timeout=3 https://www.google.com
    # Returns the exit status of wget command
    return $?
}

# Call the check_internet function
if ! check_internet; then
    echo "No internet connection. Attempting to authenticate..."

    #Authenticates using LDAP credentials 
    curl --location-trusted -u (ldapid):(internetaccesstoken) "https://internet.iitb.ac.in/login.php" >/dev/null
else
    echo "Internet connection is active."
fi
