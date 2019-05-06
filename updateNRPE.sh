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
# Author: drspritei
#
# Updated: 06.05.2019 Andre Hotzlei
#
# ---------------------------------------------------------------------

## Variable Setup ##
configFile="/etc/nagios/nrpe.cfg"
hostNagiosHostname="your.domain.com"


## Shouldn't have to change these variables ##
configIP=$( grep -o -P '(?<=allowed_hosts=)[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $configFile )
hostNagiosIP=$( host $hostNagiosHostname | awk '{ print $4 }' )


## Shouldn't have to change these variables ##
configIP=$( grep -o -P '(?<=allowed_hosts=)[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $configFile )
#hostNagiosIP=$( host $hostNagiosHostname | awk '{ print $4 }' )
hostNagiosIP=$( dig $hostNagiosHostname  |  egrep "IN.*A" | egrep -v "^;"| awk '{ print $5 }' )


## Core ##
if [ "$configIP" = "$hostNagiosIP" ]; then
        echo "Config IP $configIP matches $hostNagiosHostname IP of $hostNagiosIP. No changes needed."
else
        echo "Config IP $configIP is different than $hostNagiosHostname IP. Changing config IP to $hostNagiosIP"
        sed -ri  's/allowed_hosts=[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/allowed_hosts='$hostNagiosIP'/g' $configFile
        systemctl restart nagios-nrpe-server
fi
