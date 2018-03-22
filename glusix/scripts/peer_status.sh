#!/usr/bin/env ksh

GLUSTER=`which gluster`
PEERNAME="${1:-all}"
ATTR="${2}"
PARAM1="${3}"
PARAM2="${4}"

if [[ ${PEERNAME} == 'all' ]]; then
    output=`${GLUSTER} peer status 2>/dev/null`
    all=`echo "${output}" | grep -e "^State:" | wc -l`
    sum=`echo "${output}" | grep -e "^State:" | grep "(Connected)" | wc -l`
    if [[ ${ATTR} == 'peers' ]]; then
	res=`echo "${output}" | grep -e "^Number of Peers:" | awk -F: '{print $2}'|awk '{$1=$1};1'`
    elif [[ ${ATTR} == 'quorum' ]]; then
	res=`echo $(( (${sum}+1*100) / ${all}+1 ))`
    elif [[ ${ATTR} == 'online' ]]; then
	res=`echo $(( ${sum}+1 ))`
    elif [[ ${ATTR} == 'total' ]]; then
	res=`echo $(( ${all}+1 ))`
    fi
else
    output=`${GLUSTER} pool list 2>/dev/null`
    match=`echo "${output}"|awk '$2 ~ /^'${PEERNAME:-localhost}'$/{print}'`
    if [[ ${ATTR} == 'state' ]]; then
	res=`echo "${match}"|awk '{print $3}'`
    elif [[ ${ATTR} == 'id' ]]; then
	res=`echo "${match}"|awk '{print $2}'`
    fi
	
fi
echo "${res:-0}"
