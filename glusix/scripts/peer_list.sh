#!/usr/bin/env ksh

GLUSTER=`which gluster`

for pool in `${GLUSTER} pool list 2>/dev/null|egrep -v "(^UUID|^$)"`; do
   id=`echo ${pool}|awk -F: '{print $1}'|awk '{$1=$1};1'`
   host=`echo ${pool}|awk -F: '{print $2}'|awk '{$1=$1};1'`
   state=`echo ${pool}|awk -F: '{print $2}'|awk '{$1=$1};1'`
   echo "${id}|${host}|${state}"
done
