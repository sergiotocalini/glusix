#!/usr/bin/env ksh

GLUSTER=`which gluster`
VOLNAME="${1}"
ATTR="${2:-status}"
PARAM1="${3}"
PARAM2="${4}"

output=`${GLUSTER} volume info ${VOLNAME} 2>/dev/null`
if [[ ${ATTR} == 'status' ]]; then
   res=`echo "${output}"|grep -e "^Status:"|awk -F: '{print $2}'|awk '{$1=$1};1'`
elif [[ ${ATTR} == 'id' ]]; then
   res=`echo "${output}"|grep -e "^Volume ID:"|awk -F: '{print $2}'|awk '{$1=$1};1'`
elif [[ ${ATTR} == 'type' ]]; then
   res=`echo "${output}"|grep -e "^Type:"|awk -F: '{print $2}'|awk '{$1=$1};1'`
elif [[ ${ATTR} == 'transport' ]]; then
   res=`echo "${output}"|grep -e "^Transport-type:"|awk -F: '{print $2}'|awk '{$1=$1};1'`
fi
echo "${res:-0}"
