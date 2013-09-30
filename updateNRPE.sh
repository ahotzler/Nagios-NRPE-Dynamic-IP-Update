#!/bin/bash
# Quick script to check the NRPE config file for the allowed_hosts
# variable, and compare it to a Nagios host system's Dynamic IP.
# If the values don't match, then it updates nrpe.cfg to the new IP
# address of the host system, and restarts NRPE.
#
# This script is licensed under GNU GPL version 2.0 or above.
# Feel free to modify, change and do whatever you want.
#
# Created: September 29, 2013
# Author: drsprite
#
# ---------------------------------------------------------------------

## Variable Setup ##
configFile="/etc/nagios/nrpe.cfg"
configIP=$( grep -o -P '(?<=allowed_hosts=)[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $configFile )

hostNagiosHostname="your.domain.com"
hostNagiosIP=$( host $hostNagiosHostname | awk '{ print $4 }' )


## Core ##
if [ "$configIP" == "$hostNagiosIP" ]; then
        echo "Config IP $configIP matches $hostNagiosHostname IP of $hostNagiosIP. No changes needed."
else
        echo "Config IP $configIP is different than $hostNagiosHostname IP. Changing config IP to $hostNagiosIP"
        sed -i -r "s/allowed_hosts=[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/allowed_hosts=$hostNagiosIP/g" $configFile
        service nrpe restart
fi