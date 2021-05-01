#!/usr/bin/env bash

input=$@
result="$input"
if [[ "$input" =~ "http" ]]
then
  result="${input//https*:\/\//$'git@'}"
  result="${result//github.com\//$'github.com:'}"
  echo "INFO: changed url to ssh"
fi

git clone "$result"
