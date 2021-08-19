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

