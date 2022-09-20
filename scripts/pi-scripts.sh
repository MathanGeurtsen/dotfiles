#!/usr/bin/env bash
[ -z "$BASH_VERSION" ] && [ -z "ZSH_VERSION" ] && echo >2 "I require bash to run" && exit 1

pibox() {
  if (ssh -i ~/.ssh/testbox2 -o ConnectTimeout=3 -p 8022 mathan@192.168.0.10 hostname | grep -q "raspberrypi"); then
    echo running ssh session locally
    ssh -i ~/.ssh/testbox2 -p 8022 mathan@192.168.0.10 $@
  elif (ssh -i ~/.ssh/testbox2  -o ConnectTimeout=3 -p 8022 mathan@happy.mathangeurtsen.nl hostname | grep -q "raspberrypi"); then
    echo running ssh session over internet
    ssh -i ~/.ssh/testbox2 -p 8022 mathan@happy.mathangeurtsen.nl $@
  elif (ssh -i ~/.ssh/testbox2 -o ConnectTimeout=3 -p 8022 mathan@10.8.0.1 hostname | grep -q "raspberrypi"); then
    echo running ssh session over vpn
    ssh -i ~/.ssh/testbox2 -p 8022 mathan@10.8.0.1 $@
  fi
}

pi_status (){
  if ! (hostname | grep -q "raspberrypi"); then
    echo "only run on pi"
    return 1
  fi
  pihole status

  sudo wg show
  res=0
  if (curl  localhost:80 2> /dev/null  | grep -q "html></html>"); then 
    echo "nginx up"; 
  else
    echo "nginx down"; 
    res=1
  fi

  if (sudo ufw status | head -n1 | grep -q "Status: active"); then 
    echo "ufw up"; 
  else
    echo "ufw down"; 
    res=1
  fi

  return $res
}

pi_restart_services() {
  if ! (hostname | grep -q "raspberrypi"); then
    echo "only run on pi"
    return 1
  fi

  sudo ufw -f enable
  sudo systemctl enable ufw
  sudo systemctl restart nginx
  sudo systemctl enable nginx
  sudo systemctl restart ssh.service
  sudo systemctl enable ssh.service

  wg-quick down wg1
  sleep 5
  wg-quick up wg1

  pihole enable
  pihole restartdns
  pi_status
}

client_pi_status (){
  # run on client

  # wifi/dns _frequently_ cause issues
  if [ "$1" = "--flush" ]; then
    sudo systemctl restart systemd-resolved.service
    nmcli radio wifi off; nmcli radio wifi on 
    sleep 8
  fi
  res=0
  if (dig +short vpn.pibox.app | grep -q "10.8.0.1"); then
    echo "dns hit for vpn.pibox.app";
  else
    echo "can't resolve vpn.pibox.app";
    res=1
  fi

  if (dig +short local.pibox.app | grep -q "192.168.0.10"); then
    echo "dns hit for local.pibox.app";
  else
    echo "can't resolve local.pibox.app";
    res=1
  fi

  if (wget --tries=2 --connect-timeout=3 --output-document=/tmp/wget-out vpn.pibox.app 2> /dev/null >/dev/null && grep -q '<!DOCTYPE html></html>' /tmp/wget-out); then
    echo "vpn.pibox.app up";
  else
    echo "vpn.pibox.app down, did you connect to vpn?";
    res=1
  fi
  if (wget --tries=2 --connect-timeout=3  --output-document=/tmp/wget-out local.pibox.app 2> /dev/null >/dev/null && grep -q '<!DOCTYPE html></html>' /tmp/wget-out); then
    echo "local.pibox.app up";
  else
    echo "local.pibox.app down, are you on local network?";
    res=1
  fi
  return $res
}

#!/usr/bin/env bash

help() {
  echo "Usage: pi-scripts [-hv] function [function...]
various pi scripts. 
options:
-h, --help          : print this message
-v, --verbose       : enable trace
-f, --flush         : flush dns and restart wifi (only applicable to client-pi-status)
client-pi-status    : basic check dns hits and site availability
pibox               : ssh into pi, try locally first
pi-status           : check status of various pi services
pi-restart-services : restart pi services
"
  exit $1
}

parse_args() {
  flush=""
  funcs=()
  while :; do
    case "${1-}" in
      -h | --help)    help 0 ;;
      -v | --verbose) set -x ;;
      -f | --flush)   flush="--flush" ;;

      --) shift; break ;; 
      -?*) echo "Unknown option: '$1'" >&2; help 1 ;;
      *) break;;
    esac
    shift
  done

  while :; do
    case "${1-}" in
      client-pi-status) funcs+=("client_pi_status $flush") ;;
      pibox) funcs+=("pibox") ;;
      pi-status) funcs+=("pi_status") ;;
      pi-restart-services) funcs+=("pi_restart_services") ;;

      *) if [ -n "$1" ]; then echo "Unknown function: '$1'" >&2; help 1; fi; break ;;
    esac
    shift
  done

  if [ ${#funcs} -eq 0 ]; then
    help 1;
  fi

  return 0
}

main() {
  parse_args "$@"
  for ((i=0; i < ${#funcs[@]}; i++)); do
    echo "executing: '${funcs[$i]}'"
    eval "${funcs[$i]}"
  done
}

( # check if sourced, otherwise execute main https://stackoverflow.com/a/28776166
  [ -n $ZSH_VERSION ] && echo "$ZSH_EVAL_CONTEXT" | grep "/:file$/" ||
    [ -n $BASH_VERSION ] && (return 0 2>/dev/null)
) || main $@
