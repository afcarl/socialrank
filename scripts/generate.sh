#!/bin/bash

LOCKFILE=/tmp/generate_lock.txt
if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
    echo "generate already running"
    exit
fi

# make sure the lockfile is removed when we exit and then claim it
trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}

(cd /home/louyang/webapps/socialrank/socialrank; /usr/local/bin/python2.7 manage.py generate);

rm -f ${LOCKFILE}