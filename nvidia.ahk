; only record keys when readMode active
if (readMode == ""){
  readmode:=0
}

  
; variables
highVisibility:=0
pid:=0


; functions
resetNvidiaCtrlpanel() {
  if (not WinExist "NVIDIA Control Panel" ) {
    ; may require setting execution rights
    Run "C:\Program Files\WindowsApps\NVIDIACorp.NVIDIAControlPanel_8.1.962.0_x64__56jybvy8sckqj\nvcplui.exe", , ,pid
    sleep 2000
  } else {
    WinActivate "NVIDIA Control Panel"
    sleep 500
  }
  WinActivate ahk_pid %pid%
  sleep 200
  Click 122 220 ; Adjust desktop color settings
  Click 886 130 ; Restore Defaults
}

setHighVis() {
  resetNvidiaCtrlpanel()
  MouseClickDrag, left, 559, 517, 612, 517 ; Brightness
  MouseClickDrag, left, 559, 549, 641, 549 ; Contrast
  MouseClickDrag, left, 525, 575, 606, 575 ; Gamma
}


; keys
#if readMode

F9:: ; toggle setting nvidia settings between high brightness and standard
if (%highVisibility% != 0) {
  resetNvidiaCtrlpanel()
  highVisibility:=0
} else {
  setHighVis()
  highVisibility:=1
}
return
#If