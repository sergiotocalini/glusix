# glusix
Zabbix Agent - Gluster

# Dependencies
## Packages
* ksh
* bc
* awk

### Debian/Ubuntu
```bash
~# sudo apt install ksh bc awk
~#
```
### Red Hat
```bash
~# sudo yum install ksh bc awk
~#
```
# Deploy
The deploy script is not intended to advise which approach you should implemented nor
deploy the sudoers configuration but the user that will run the script needs be running
with sudo privileges.

There are two options to setting up sudoers for the user:
1. Provided sudo all
```bash
~# cat /etc/sudoers.d/user_zabbix
Defaults:zabbix !syslog
Defaults:zabbix !requiretty

zabbix	ALL=(ALL)  NOPASSWD:ALL
~#
```
2. Limited acccess to run command with sudo
```bash
~# cat /etc/sudoers.d/user_zabbix
Defaults:zabbix !syslog
Defaults:zabbix !requiretty

zabbix ALL=(ALL) NOPASSWD: /usr/sbin/glusterd *
zabbix ALL=(ALL) NOPASSWD: /usr/bin/gluster *
~#
```

## Zabbix
Please ensure that the zabbix user has the right permissions before continue with
the installation.
```bash
~# git clone https://github.com/sergiotocalini/glusix.git
~# sudo ./glusix/deploy_zabbix.sh
~# sudo systemctl restart zabbix-agent
```
*Note: the installation has to be executed on the zabbix agent host and you have to import the template on the zabbix web.*
