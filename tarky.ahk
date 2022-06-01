; only record keys when readMode active
if (readMode == ""){
  readmode:=0
}


; variables

tarkState:=0
moveSpeed:=5


; functions
openFlea() {
  global moveSpeed
  MouseMove,  1000, 1063, moveSpeed
  Click ; reset opened tab
  MouseMove,  1249, 1065, moveSpeed
  Click ; open flea
  MouseMove, 1215, 67, moveSpeed
  Click ; add order
  MouseMove, 479, 47, moveSpeed
  Click ; autoselect
}

setCurrency() {
  global moveSpeed
  MouseGetPos, xpos, ypos 
  MouseMove, 1055, 376, moveSpeed
  Click ; open requirement window
  MouseMove, xpos, ypos, moveSpeed
  MouseClick, right 
  MouseMove, 92, 60, moveSpeed, R
  ; open right mouse menu and position cursor roughly right
}

completeOffer() {
  global moveSpeed
  MouseMove, 973, 916, moveSpeed
  Click
  MouseMove, 950, 756, moveSpeed
  Click
}


; keys

#if readMode

F11:: ; go through 3 states of selling an item
if WinActive("EscapeFromTarkov") {
  SetKeyDelay, 500
  if (tarkState == 0) {
    openFlea()
    tarkState:=1
  } else if (tarkState == 1) {
    setCurrency()
    tarkState:=2
  } else if (tarkState == 2) {
    completeOffer()
    tarkState:=0
  }
}
return


F10:: ; reset state
tarkState:=0
return
#If