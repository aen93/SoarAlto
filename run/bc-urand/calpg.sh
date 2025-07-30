#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 [dir] [thcnt]"
  exit 1
fi
RSTDIR=$1
thcnt=$2

F="pgstat-th${thcnt}.log"

grep "pgpromote_success" $RSTDIR/$F | awk '{print$2}' | awk 'NR==1{start=$0} {end=$0} END{print "Start:", start; print "End:", end; print end-start}'

cat "$RSTDIR/time-th${thcnt}.log"