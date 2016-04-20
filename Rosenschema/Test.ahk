#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Sysget, mon1,MonitorWorkArea,1
WorkWidth := Mon1Right - Mon1Left
WorkHeight := Mon1Bottom - Mon1Top
!s::
Sysget, mon1,MonitorWorkArea,1
WorkWidth := Mon1Right - Mon1Left
WorkHeight := Mon1Bottom - Mon1Top
loop, read, currentid
;	MsgBox, %A_LoopReadLine%
loop, read, C:\Users\leooka1ros\Desktop\Rosenschema\id
{
Array%A_index% := A_LoopReadLine
Array0 = %A_Index%
}
Loop, %Array0%
	Options .= Array%A_Index% . "|"

GUI,New,+Resize -sysmenu ,TEST	;+MinSize%WorkWidth%x%WorkHeight% 
GUI,Add,DropDownList,vTest, %Options%
Gui, Add, Picture,x0 BackgroundTrans,Schema.png
GUi, add, picture,x100 y100 gTest, Untitled.png
Gui, Show
Gui, Maximize
return

Test:
msgbox, hej
return