#!/usr/bin/env bash

# curl-smtp-google is a small mail utility to send simple mail
# from the terminal that should be useable just about anywhere.

# Copyright (C) 2020 Mathan Geurtsen

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, either version 2 of the
# License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public
# License along with this program.  If not, see
# <https://www.gnu.org/licenses/>.

print_usage () {
  echo "
Usage 
  curl-smtp-google [options] <sender_google_username> <sender_google_password> <recipient_mail_address> <subject> <file_path>

Options:
 -h --help: print this message
 -n --no-force-ssl: make a connection without forcing ssl
 -p --print-no-send
 -b --body <body>
"
}

# arg parser
# adapted from https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
PARAMS=""

ssl_option="--ssl-reqd"
send=1
body=""

while (( "$#" )); do
  case "$1" in
    -h|--help)
      print_usage
      exit
      ;;
    -n|--no-force-ssl)
      ssl_option="--ssl"
      shift 2
      ;;
    -p|--print-no-send)
      send=0
      shift 1
      ;;
    -b|--body)
      body=$2
      shift 2
      ;;

    --) # end argument parsing
     shift
      break
      ;;
    -*|--*=) # unsupported flags
    echo "Error: Unsupported flag $1" >&2
    print_usage
    exit 1
    ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

# set positional arguments in their proper place
eval set -- "$PARAMS"

# parse the first positional arguments
sender_google_username=$1; shift; echo $sender_google_username
sender_google_password=$1; shift; echo $sender_google_password
recipient_mail_address=$1; shift; echo $recipient_mail_address
subject=$1; shift; echo $subject
filepath=$@; echo $filepath

message_file=$(mktemp)

# create message
if [[ body = "" ]]; then
  echo "From: $sender_google_username@gmail.com
To: $recipient_mail_address
Subject: $subject
Date: $(date +%c)
\n\n
"$body>$message_file
  filepath=$message_file
else
  echo -e "From: $sender_google_username@gmail.com
To: $recipient_mail_address
Subject: $subject
Date: $(date +%c)
\n\n" | cat - $filepath > $message_file
fi



# before sending check if every field is filled, and if the mail addresses are correctly formed
if ! ([[ $sender_google_password ]] && [[ $subject ]] && [[ $filepath ]] ); then     
  echo "Error: one or more arguments unfilled. " >&2
  print_usage
  exit 1
fi
if  ! ([[ "$sender_google_username@gmail.com" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]] && [[ "$recipient_mail_address" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]); then
  echo "the mail addresses were incorrectly formatted." >&2
  print_usage
  exit 1
fi

# execute or print the curl command
if [[ $send = 1 ]]; then

  curl --url "smtps://smtp.gmail.com:465" $ssl_option \
       --mail-from "$sender_google_username@gmail.com" \
       --mail-rcpt "$recipient_mail_address" \
       --user "$sender_google_username@gmail.com:$sender_google_password" \
       --upload-file $message_file

else
  echo "curl --url \"smtps://smtp.gmail.com:465\" $ssl_option \\
    --mail-from \"$sender_google_username@gmail.com\" \\
    --mail-rcpt \"$recipient_mail_address\" \\
    --user \"$sender_google_username@gmail.com:$sender_google_password\" \\
    --upload-file $message_file"
fi

