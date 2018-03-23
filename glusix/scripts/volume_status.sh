#!/usr/bin/env ksh

GLUSTER="sudo `which gluster`"
VOLNAME="${1}"
ATTR="${2:-bricks}"
PARAM1="${3}"
PARAM2="${4}"

if [[ ${ATTR} =~ (bricks|inode|size) ]]; then
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
    elif [[ ${ATTR} == 'inodes' ]]; then
	if [[ ${PARAM1:-total} == 'total' ]]; then
	    res=`echo "${output}" | grep -e "^Inode Count" | \
           awk -F: '{print $2}'|awk '{$1=$1};1'|sort -n|head -1`
	elif [[ ${PARAM1} == 'free' ]]; then
	    if [[ ${PARAM2} == 'perc' ]]; then
		total=`echo "${output}" | grep -e "^Inode Count" | \
		       awk -F: '{print $2}'|awk '{$1=$1};1'|sort -n|head -1`
		free=`echo "${output}" | grep -e "^Free Inodes" | \
               	      awk -F: '{print $2}'|awk '{$1=$1};1'|sort -n|head -1`
		res=`echo $(( (${free}*100) / ${total}))`
	    else
		res=`echo "${output}" | grep -e "^Free Inodes" | \
        	     awk -F: '{print $2}'|awk '{$1=$1};1'|sort -n|head -1`
	    fi
	fi
    fi
elif [[ ${ATTR} == 'clients' ]]; then
    output=`${GLUSTER} volume status ${VOLNAME} clients 2>/dev/null`
    if [[ ${PARAM1:-connected} == "connected" ]]; then
	raw=`echo "${output}"|grep -e "^Clients connected : "|awk -F: '{print $2}'|awk '{$1=$1};1'`
	all=`echo "${raw:-0}"|wc -l`
	sum=`echo "${raw:-0}"|paste -sd+ -|bc`
	res=`echo $(( ${sum:-0} / ${all} ))`
    elif [[ ${PARAM1} == "hosts" ]]; then
	raw=`echo "${output}"|grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
	res=`echo "${raw}"|sort|uniq|wc -l`
    elif [[ ${PARAM1} == "bytes" ]]; then
	raw=`echo "${output}"|grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'`
	if [[ ${PARAM2} == 'read' ]]; then
	    raw=`echo "${raw}"|awk '{print $2}'|awk '{$1=$1};1'`
	    res=`echo "${raw:-0}"|paste -sd+ -|bc`
	elif [[ ${PARAM2} == 'written' ]]; then
	    raw=`echo "${raw}"|awk '{print $3}'|awk '{$1=$1};1'`
	    res=`echo "${raw:-0}"|paste -sd+ -|bc`
	fi
    fi
fi
echo "${res:-0}"
