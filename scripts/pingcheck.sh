#!/usr/bin/bash

ext-reb () {
  RET=0
  while [ $RET -eq 0 ]; do
    echo $(date +%H:%M:%S) trying again
    curl https://extinctionrebellion.nl/ 2>&1 | tee ~/extinctionrebellion.html | grep "Failed to connect"
  RET=$?
  sleep 10
  done
  echo downloaded
}

function background-verify-connection {
  # notify when connection is down. defaults to DNS, else $1
  if [ -z "$1" ] 
  then
    host="8.8.8.8"
  else
    host=$1
  fi
  
  while true
  do
    ping $host -c 1 > /tmp/pingcheck_output 2>&1
    if test 0 = $(grep -c "64 bytes from" /tmp/pingcheck_output); then
      message="$(date +%H:%M:%S): connection seems down!"
      notify-send "$message"
      echo "$message"
    else
      echo "$(date +%H:%M:%S): connection up"
      sleep 5
    fi
    sleep 2
  done
}

function background-note-connection {
  # notify when connection is up. defaults to DNS, else $1
  if [ -z "$1" ] 
  then
    host="8.8.8.8"
  else
    host=$1
  fi
  
  while true
  do
    ping $host -c 1 > /tmp/pingcheck_output 2>&1
    if test 0 = $(grep -c "64 bytes from" /tmp/pingcheck_output); then
      echo "$(date +%H:%M:%S): connection still down" 
    else
      message="$(date +%H:%M:%S): connection up! "
      notify-send "$message"
      echo "$message"

      sleep 5
    fi
    sleep 2
  done
}

int_from_col() {
  # Extract integer from space separated value assignments, only outputs if the cell contains the correct variable name. 
  # example: 
  # > int_from_col 2 "a=1 b=3.23" "b"
  # 3
  column=$1
  var_name=$3
  echo "$2" | awk -v column="$column" -v var_name="$var_name" '{
    cell = $column; 
    start_ind = match(cell, "=") + 1;
    end_ind = match(cell,"\\.");
    if (end_ind == 0)
      end_ind = length(cell);
  
    if(cell ~ var_name)
    {
      print(substr(cell, start_ind, end_ind - start_ind))
      exit 0
    } 
    exit 1
  }'
  return $?
}

ping_time() {
  site="$1"
  ping_output="$(ping -c 1 -v "$site")"
  echo "$ping_output" | while IFS= read -r line ; do
    temp="$(int_from_col 8 "$line" "time")"
    if [ "$?" -eq 0 ]; then
      echo "$temp"
      break
    fi
  done | cat
}

ping_avg() {
  site="$1"
  if [ -z "$2" ]; then n=10; else n="$2"; fi
  if [ "$3" = "true" ]; then inline=true;  echo ""; else inline=false; fi  
  i=0
  avg=0
  while [ "$i" -le "$n" ]; do
    cur_ping="$(ping_time "$site")"
    avg=$(( (avg * i + cur_ping) / (i+1)))
    if $inline; then
      echo -e '\e[1A\r\e[K'"avg ping time: $avg"
    fi
    i=$((i + 1))
  done
  if ! $inline; then
      echo "$avg"
  fi
}
