; only record keys when readMode active
if (readMode == ""){
  readmode:=0
}


; variables
doWatch:=0


; functions
WatchCursor() {
  global doWatch
  if (%doWatch% != 0) {
    MouseGetPos, , , id, control
    WinGetTitle, title, ahk_id %id%
    WinGetClass, class, ahk_id %id%
    MouseGetPos, xpos, ypos 
    ToolTip, ahk_id %id%`nclahk_class: %class%`ntitle: %title%`nControl: %control%`nx %xpos%y %ypos%

  } else {
    ToolTip
  }
  return
}


; keys
#if readMode

F12:: ; toggle a tooltip with basic info, useful for building ahk
SetTimer, WatchCursor, 100
if (doWatch == 1) {
  doWatch:=0
} else {
  doWatch:=1
}
return
#If