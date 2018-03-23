#!/usr/bin/env ksh

GLUSTERD="sudo `which glusterd`"

${GLUSTERD} -V | head -1 | awk '{print $2}'
