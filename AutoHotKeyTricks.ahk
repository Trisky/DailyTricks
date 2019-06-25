
;IMPORTANT In order for the mute mic toggle to work this number must be edited. 
;To find out which number you have to use, you should use the check sound cards script. 
soundDeviceId := 9 ;9 was my mic id number.


;==============================================
;Toggle mic mute 
;toggles mute mic, shows a tool tip and sets a tray icon accordingly. 
;https://autohotkey.com/boards/viewtopic.php?t=15509
#MButton:: ;windows + mouse3

SoundSet, +1, MASTER, mute,soundDeviceId 
SoundGet, master_mute, , mute, soundDeviceId
ToolTip, Mute %master_mute% ;use a tool tip at mouse pointer to show what state mic is after toggle
SetTimer, RemoveToolTip,1000
if (master_mute == "On") {
    Menu, Tray, Icon, shell32.dll, 110,1 ;red cross
} else {
    Menu, Tray, Icon, shell32.dll, 1,1 ; white paper
}
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return
;END toggle mouse mute
;==========================================

;Mouse media shortcuts
#PgUp::Send {Volume_Up 3} 
#PgDn::Send {Volume_Down 3}
#WheelUp::Send {Volume_Up 2} ;windows + scroll up
#WheelDown::Send {Volume_Down 2}
#lbutton::Send {Volume_Mute}  ;windows + mouse1

#rbutton::Send {Media_Play_Pause} ;windows + mouse2
#XButton1::Send {Media_Prev}  ;windows + mouse4
#XButton2::Send {Media_Next} ;windows + mouse5

#WheelRight::Send ^#{Right}  ;;desktop change: windows + mouse scroll right
#WheelLeft::Send ^#{Left}    ;;desktop change

;Buttons remap steelseries pro m keyboard
PrintScreen::NumpadDiv
ScrollLock::NumpadMult
Pause::NumpadSub
Insert::NumpadSub