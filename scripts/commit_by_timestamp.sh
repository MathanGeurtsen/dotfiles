#!/usr/bin/env bash
timestamp="2022-03-23 09:18:58"
unix_timestamp="$(date -d "$timestamp" +%s --utc)"
log_times="$(git log | awk '/Date/ {for  (i=2; i<NF-1; i++) printf $i" " ; print $NF}' |xargs -I{} date -d "{}"  +%s --utc)"


IFS=$(echo -en "\n\b")
i=0
for log_time in ${log_times}; do 
  i=$((i+1))
  if [ "$unix_timestamp" -ge "$log_time" ]; then
    echo i is $i
    break
  fi
done
