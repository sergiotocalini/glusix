#!/usr/bin/env ksh
SOURCE_DIR=$(dirname $0)
ZABBIX_DIR=/etc/zabbix

mkdir -p ${ZABBIX_DIR}/scripts/agentd/glusix
cp -rv ${SOURCE_DIR}/glusix/scripts              ${ZABBIX_DIR}/scripts/agentd/glusix/
cp -rv ${SOURCE_DIR}/glusix/glusix.conf.example  ${ZABBIX_DIR}/scripts/agentd/glusix/glusix.conf
cp -rv ${SOURCE_DIR}/glusix/glusix.sh            ${ZABBIX_DIR}/scripts/agentd/glusix/
cp -rv ${SOURCE_DIR}/glusix/zabbix_agentd.conf   ${ZABBIX_DIR}/zabbix_agentd.d/glusix.conf

