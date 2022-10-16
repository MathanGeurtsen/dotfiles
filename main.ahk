#SingleInstance force

;variables
readMode:=0
docList=F1: reset script`nF9: toggle nvidia settings`nF10: reset tarkov state`nF11: advance tarkov state`nF12: ahk info tooltip

; show restart
MsgBox, 0, ,restarted script, 0.3


; scripts to run

#include tarky.ahk
#include watchCursor.ahk
#include nvidia.ahk


; functions

resetReadMode() {
  global readMode
  readMode := 0
  ToolTip
}

; keys


F7:: ; prefix key
if (readMode == "" or readMode == 0){
  readModeTimeout := 1000
  ToolTip, %docList%
  readMode:=1
  SetTimer, resetReadMode, -%readModeTimeout%
} else {
  readMode:=0
}
return
#if readMode
F1:: ; reset script
Reload
return
#If