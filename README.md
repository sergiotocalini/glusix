# glusix
Zabbix Agent - Gluster

# Dependencies
## Packages
* ksh
* bc

### Debian/Ubuntu
```bash
~# sudo apt install ksh bc
~#
```
### Red Hat
```bash
~# sudo yum install ksh
~#
```
# Deploy
## Zabbix
```bash
~# git clone https://github.com/sergiotocalini/glusix.git
~# sudo ./glusix/deploy_zabbix.sh
~# sudo systemctl restart zabbix-agent
```
*Note: the installation has to be executed on the zabbix agent host and you have to import the template on the zabbix web.*
