#!/usr/bin/bash

echo -n $@ | xclip -sel primary
echo -n $@ | xclip -sel secondary
echo -n $@ | xclip -sel clipboard
