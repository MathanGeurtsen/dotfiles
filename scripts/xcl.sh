#!/usr/bin/bash

tempfile="$(mktemp -t tmp.XXXXXX)"
echo -n $@ > $tempfile;
xclip -selection clipboard $tempfile;
rm $tempfile
