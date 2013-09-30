nagios-nrpe-dyanmic-ip-update
=============

(c) drsprite <drsprite@github.com> - http://github.com/drsprite
Licensed under the GNU GPL 2.0 or later.

If your host Nagios system is behind a dynamic DHCP IP, and you use
NRPE to monitor remote Nagios systems, then this script should be
able to help you out. 

Designed to check your Nagios host DHCP IP, and compare it to the client 
NRPE config file. A config file update will occur if the IP values do not
match. Once the config file is updated, the NRPE service is restarted. 

### INSTALLATION

Drop into a directory of your choosing. 
chmod +x updateNRPE.sh
Edit the file variables to match your setup (host Nagios hostname).
./updateNRPE to run it adhoc.
Add it to cron to schedule update checks.
	
	
### DEBUG INFO

If for some reason things aren't working, you can check the variables being passed to Nagios 
by simply uncommenting the echo's within the scripts. 

### AVAILABILITY

This script can be found at https://github.com/drsprite/nagios-nrpe-dyanmic-ip-update

