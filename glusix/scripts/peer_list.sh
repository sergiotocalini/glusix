#!/usr/bin/env ksh

GLUSTER="sudo `which gluster`"

${GLUSTER} pool list 2>/dev/null|egrep -v "(^UUID|^$)" | while read line; do
   id=`echo ${line}|awk '{print $1}'|awk '{$1=$1};1'`
   host=`echo ${line}|awk '{print $2}'|awk '{$1=$1};1'`
   state=`echo ${line}|awk '{print $3}'|awk '{$1=$1};1'`
   echo "${id}|${host}|${state}"
done
