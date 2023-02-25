#!/usr/bin/env bash
[ -z "$BASH_VERSION" ] && [ -z "ZSH_VERSION" ] && echo >2 "I require bash to run" && exit 1

set -e

help() {
  echo "Usage: script_name [-hv] arg

options:
-h, --help    : print this message
-v, --verbose : verbose output
-u, --up      : send notification if it is up
-d, --down    : send notification if it is down
-s, --server  : host to ping, defaults to 1.1.1.1
-c            : number of pings to send, defaults to 5
-C            : continuous mode
 
"
  exit $1
}

send_ping() {
  while true
  do
    if test "$verbose" == 0; then
      echo -en "\n-- "
      ping $host -c "$count" | tee /tmp/pingcheck
      echo -e "--\n"
    else
      ping $host -c "$count" | tee /tmp/pingcheck > /dev/null

    fi

    output="$(cat "/tmp/pingcheck")"

    re_loss="([0-9]+)% packet loss"; 
    re_rtt="rtt min/avg/max/mdev = .+?/([0-9]+).+?/([0-9]+).+?/([0-9]+).+? ms"; 

    avg=0
    max=0
    mdev=0
    loss=100
    print=""

    [[ $output =~ $re_loss ]] && loss="${BASH_REMATCH[1]}"

    if [[ $output =~ $re_rtt ]]; then
      avg="${BASH_REMATCH[1]}"
      max="${BASH_REMATCH[2]}"
      mdev="${BASH_REMATCH[3]}"

      title="$(date +%H:%M:%S): connection up!"
      body="packet loss: $loss%, rtt: $avg ms (+- $mdev) (n=$count)"

      if test "$up" == 0; then
        notify-send "$title" "$body"
      fi

      echo -e "$title" "$body"
    else
      title="$(date +%H:%M:%S): connection seems down!"
      echo "$title"
      if test "$down" == 0; then notify-send "$title"; fi
    fi

    if test "$continuous" == 1; then break; fi
  done
}

parse_args() {
  myvar=""
  args=()
  up=1
  down=1
  host="1.1.1.1"
  count=5
  continuous=1  
  verbose=1  
  # parse flag arguments
  while :; do

    case "${1-}" in
      -h | --help)    help 0 ;;
      -v | --verbose) set -x; verbose=0 ;;
      -u | --up) up=0 ;;
      -d | --down) down=0 ;;
      -s | --server) shift; host="$1" ;;
      -c ) shift; count="$1" ;;
      -C ) continuous=0 ;;
      --) shift; break ;; 
      -?*) echo "Unknown option: '$1'" >&2; help 1 ;;
      *) break;;
    esac
    shift
  done

  return 0
}

main() {
  parse_args "$@"
  send_ping
}

( # check if sourced, otherwise execute main https://stackoverflow.com/a/28776166
  [ -n $ZSH_VERSION ] && echo "$ZSH_EVAL_CONTEXT" | grep "/:file$/" ||
      [ -n $BASH_VERSION ] && (return 0 2>/dev/null)
) || main $@
