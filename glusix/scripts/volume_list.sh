#!/usr/bin/env ksh

GLUSTER="sudo `which gluster`"

idx=0
while read line; do
   [[ -z ${line} ]] && continue
   [[ ${line} =~ (^Volume Name:) ]] && let "idx=idx+1"

   key=`echo ${line}|awk -F: '{print $1}'|awk '{$1=$1};1'`
   val=`echo ${line}|awk -F: '{print $2}'|awk '{$1=$1};1'`

   output[${idx}]+="`echo ${line}|awk -F: '{print $2}'|awk '{$1=$1};1'`|"
done < <(${GLUSTER} volume info 2>/dev/null | grep -E "^(Volume Name|Volume ID|Type|Status|Transport-type): .*$")

printf '%s\n' ${output[@]} | sed 's/.$//g'
