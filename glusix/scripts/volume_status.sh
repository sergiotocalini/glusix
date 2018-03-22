#!/usr/bin/env ksh

GLUSTER=`which gluster`
VOLNAME="${1}"
ATTR="${2:-bricks}"
PARAM1="${3}"
PARAM2="${4}"

output=`${GLUSTER} volume status ${VOLNAME} detail 2>/dev/null`
if [[ ${ATTR} == 'bricks' ]]; then
   all=`echo "${output}" | grep -e "^Online" | wc -l`
   sum=`echo "${output}" | grep -e "^Online" | grep ": Y" | wc -l`
   if [[ ${PARAM1:-quorum} == 'quorum' ]]; then
      res=`echo $(( (${sum}*100) / ${all}))`
   elif [[ ${PARAM1} == 'online' ]]; then
      res=${sum}
   elif [[ ${PARAM1} == 'total' ]]; then
      res=${all}
   fi
elif [[ ${ATTR} == 'inode' ]]; then
   if [[ ${PARAM1:-total} == 'total' ]]; then
      res=`echo "${output}" | grep -e "^Inode Count" | \
           awk -F: '{print $2}'|awk '{$1=$1};1'|sort -n|head -1`
   elif [[ ${PARAM1} == 'free' ]]; then
      if [[ -z ${PARAM2} ]]; then
         res=`echo "${output}" | grep -e "^Free Inodes" | \
              awk -F: '{print $2}'|awk '{$1=$1};1'|sort -n|head -1`
      elif [[ ${PARAM2} == 'perc' ]]; then
         total=`echo "${output}" | grep -e "^Inode Count" | \
		awk -F: '{print $2}'|awk '{$1=$1};1'|sort -n|head -1`
         free=`echo "${output}" | grep -e "^Free Inodes" | \
               awk -F: '{print $2}'|awk '{$1=$1};1'|sort -n|head -1`
         res=`echo $(( (${free}*100) / ${total}))`
      fi
   fi
fi
echo "${res:-0}"
