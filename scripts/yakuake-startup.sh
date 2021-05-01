#!/bin/bash
###########################################################################
# config file adapted from https://wiki.archlinux.org/index.php/Yakuake   #
# original comments preempted with "#-"                                   #
###########################################################################

#- Starting Yakuake based on user preferences. Information based on http://forums.gentoo.org/viewtopic-t-873915-start-0.html
#- Adding sessions from previous website is broken, use this: http://pawelkoston.pl/blog/sublime-text-3-cheatsheet-modules-web-develpment/

/usr/bin/yakuake &

#- gives Yakuake a couple seconds before sending dbus commands
sleep 2      
                                                 
# take the terminal id, set tab title and start tmux
TERMINAL_ID_0=$(qdbus org.kde.yakuake /yakuake/sessions org.kde.yakuake.terminalIdsForSessionId 0)
qdbus org.kde.yakuake /yakuake/tabs setTabTitle 0 "main"
qdbus org.kde.yakuake /yakuake/sessions runCommandInTerminal 0 "~/sh/standard-tmux.sh"
