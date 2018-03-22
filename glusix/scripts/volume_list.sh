#!/usr/bin/env ksh

GLUSTER=`which gluster`

for vol in `${GLUSTER} volume list 2>/dev/null`; do
   output=""
   ${GLUSTER} volume info ${vol} | while read line; do
       key=`echo ${line}|awk -F: '{print $1}'|awk '{$1=$1};1'`
       val=`echo ${line}|awk -F: '{print $2}'|awk '{$1=$1};1'`
       if [[ ${key} =~ ^(Volume Name|Volume ID|Type|Status|Transport-type)$ ]]; then
          output+="`echo ${line}|awk -F: '{print $2}'|awk '{$1=$1};1'`|"
       fi
   done
   echo ${output}|sed 's/.$//'
done
