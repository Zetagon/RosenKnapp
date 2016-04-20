#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
!m::
matsedel()
return

matsedel(){
UrlDownloadToFile,https://sites.google.com/a/rosendalsgymnasiet.se/rosnet/veckans-mat, veckansmat.txt
if errorlevel
msgbox, error
a := Object()

loop,read, veckansmat.txt
{
	a%A_index% := A_LoopReadLine
}
Stringreplace,x, a136 ,</div>,`n, 1
Stringreplace,x, x ,<div>,, 1
Stringreplace,x, x ,</b>,``, 1
Stringreplace,x, x ,<b>,``, 1
Stringreplace,x, x ,Ã¥,å, 1
Stringreplace,x, x ,Ã¤,ä, 1
Stringreplace,x, x ,Ã¶,ö, 1
Stringreplace,x, x ,<br />,, 1
;monday := Substr(x,Instr(x, "måndag"),Instr(x,"`n")-Instr(x, "måndag"))
;mondayfood := Substr(x,Instr(x, "`n"),Instr(x,"tisdag")-Instr(x, "`n"))
StringSplit,foodArray, x, ``
if errorlevel
msgbox, error
gui, new
loop, 14{
gui, font,  w700, verdana
a := 2 * A_index 
gui, add, text, , % foodArray%a% 
gui, font,  w500 , verdana
a := 2 * A_index + 1
gui, add, text, ,% foodArray%a% 

}
; gui, add, edit,, % x
gui, show, autosize
}