#!/bin/bash

outf=$1
tt=$2

echo "" > $outf
while true; do
  sleep 1
  date +%s >> $outf
  if [[ $tt == 1 ]]; then
    # Nomad
    grep "nr" /proc/perfnomad >> $outf
  else
    grep -E "demote|promote|pgmigrate|pgscan|hint" /proc/vmstat >> $outf
  fi
done
