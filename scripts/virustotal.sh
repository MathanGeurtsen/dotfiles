#!/usr/bin/bash
 firefox https://www.virustotal.com/gui/file/$(md5sum $@)
