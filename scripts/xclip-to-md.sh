#!/usr/bin/env bash
tempfile_input="$(mktemp -t tmp_XXXXXX)"
tempfile_output="$(mktemp -t tmp_XXXXXX).md"

xclip -o -selection clipboard -t text/html > $tempfile_input
pandoc -f html "$tempfile_input" -t markdown -o "$tempfile_output"
xclip -selection clipboard $tempfile_output
