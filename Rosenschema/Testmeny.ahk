#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode,3
msgbox,% "Tryck höger ctrl, och välj funktion, tryck sedan tab och skriv in en hotkey, ex. alt s"
FileCreatedir,  %A_WorkingDir%\HotkeySettings
loop, Files, %A_ScriptDir%\HotkeySettings\*.txt
{
	x = %A_ScriptDir%\HotkeySettings\%A_LoopFileName%
	FileReadLine, y, %x%, 1
	if errorlevel =  0
	{
	x := substr(A_loopFileName,1,-4)
	hotkey, % y, % x
	}
	else
		msgbox, error
	
}
; loop, read, %A_workingDir%\HotkeyInställningar
; {
	; Hotkeyarray%A_Index% := A_LoopReadLine
	; x := A_Index
; }
; msgbox, %x%
; x :=  x / 2
; stringleft,x,x,1
; loop, % x
; {
	; y := A_Index*2
	; y2 := y -1
	; Hotkey, % Hotkeyarray%y%, % Hotkeyarray%y2%
	; if errorlevel = 1
	; msgbox, 1
	; if errorlevel = 2
	; msgbox, 2 
; }

HotkeyWindow := ""
RControl up::
	gui, new
	; gui, add, text, , Skriv in ditt schema hotkey
	; Gui, Add, Hotkey, vNewHotkeySchema  limit 64
	; gui, add, text, , Skriv in din timer hotkey
	; Gui, Add, Hotkey, vNewHotkeyTimer  limit 64
	; gui, add, button, gChangeHotkey default, spara
	gui, add, DropDownList, vHotkeyToChange, schema||timer|matsedel|OpenMenulinks|link1|link2|link3|link4|link5|link6|link7|link8|link9
	gui, add, Hotkey, vNewHotkey ;limit 64
	gui, add, button, gChangeHotkey default, Spara
	Gui, show
return

; !s::
; gui, new,+Resize +MinSize640x480 ,RosenKnapp  Hotkeys
; gui, add, text, ,alsdlj
; gui, show
; WinGetClass, HotkeyWindow, A
; loop
; {
	; ifWinActive,RosenKnapp  Hotkeys ; %HotkeyWindow%
	; {}
	; else
	; {
		; gui, destroy
		; Break
	; }
; }

 ; Msgbox, % HotkeyWindow
; return

ChangeHotkey:
	; gui, submit
	; Hotkey, IfWinActive, RosenKnapp  Hotkeys ; ahk_class %HotkeyWindow% ; 
	; if not OldHotkeySchema = ""
	; hotkey, % OldHotkeySchema,off, ; disable the previous hotkey
	; OldHotkeySchema := % NewHotkeySchema
	; if not NewHotkeySchema = ""
	; hotkey, % NewHotkeySchema, schema,

	; if not OldHotkeyTimer = ""
	; hotkey, % OldHotkeyTimer,off, ; disable the previous hotkey
	; OldHotkeyTimer := % NewHotkeyTimer
	; if not NewHotkeyTimer = ""
	; hotkey, % NewHotkeyTimer, timer,
	gui, submit ;, Nohide
	FileReadLine, OldHotkey, HotkeySettings\%HotkeyToChange%.txt,1
;	msgbox, % OldHotkey
	if not OldHotkey = ""
		Hotkey, % OldHotkey, off
;	OldHotkey := NewHotkey
	if not NewHotkey = ""{
		hotkey, % NewHotkey, % HotkeyToChange, on
	temp = HotkeySettings\%HotkeyToChange%.txt
	file := FileOpen(temp, "w") ; 
	file.WriteLine(NewHotkey)
	file.close()
	}

return

nothing:
return

; schema:
; msgbox, schema
; return

timer:
	msgbox, timer
return
schema:	;Öppna schema
	Gui,destroy
	OpenSchema()
return

link1:	;The following code is to create hotkeys to hyperlinks
	linkShortcut("alt1")
return	
link2:
	linkShortcut("alt2")
return
link3:
	linkShortcut("alt3")
return
link4:
	linkShortcut("alt4")
return
link5:
	linkShortcut("alt5")
return
link6:
	linkShortcut("alt6")
return
link7:
	linkShortcut("alt7")
return
link8:
	linkShortcut("alt8")
return
link9:
	linkShortcut("alt9")
return




linkShortcut(key){
	link:=""
	file := FileOpen(key,"r")
	if file = 0
	{
		InputBox, link, Link, Det fanns ingen länk sparad på den här genvägen. Skriv in en URL här:, ,375,160
		if ErrorLevel
			return
		else
		StringReplace, x ,link, "`%", ""
		FileAppend, %link%, %key%
		file := FileOpen(key,"r")
	}
	link:= file.read()
	run, %link%
	
}
; !h::
; OpenMenulinks()
; return

OpenMenulinks:
loop, 9{
	FileRead, alt%A_Index%, alt%A_Index% 
}
	Gui, new,+Resize +MinSize640+480, Menu
	Gui, add, edit, valt1 W200 -WantReturn x0,%	Alt1
	Gui, add, edit, valt2 W200 -WantReturn x0,%	Alt2
	Gui, add, edit, valt3 W200 -WantReturn x0,%	Alt3
	Gui, add, edit, valt4 W200 -WantReturn x0,%	Alt4
	Gui, add, edit, valt5 W200 -WantReturn x0,%	Alt5
	Gui, add, edit, valt6 W200 -WantReturn x0,%	Alt6
	Gui, add, edit, valt7 W200 -WantReturn x0,%	Alt7
	Gui, add, edit, valt8 W200 -WantReturn x0,%	Alt8
	Gui, add, edit, valt9 W200 -WantReturn x0,%	Alt9
	Gui, add, button, default x640 gsavelinks, Spara
	Gui, Show
return

savelinks:
	Gui, submit
	;Gui, Destroy
	loop, 9 {
		file := FileOpen("alt" . A_Index, "w")
		x = alt%A_Index% 
		if (file =0)
			msgbox, error!
		else
			file.Write(alt%A_Index%)
		file.close()
		Guicontrol,,% alt%A_Index%,% alt%A_Index%
	}
return

OpenSchema()
{
	global
	StringRight, vecka, A_YWeek, 2
	
	Loop, %Array0%
		Array%A_Index% := ""
	Options := ""
	Array := Object()	;new array
	loop, read,	%A_workingDir%\id	; C:\Users\leooka1ros\Google Drive\Skript\Rosenschema\id	;puts every line of the file into Array
	{
		Array%A_index% := A_LoopReadLine
		Array0 = %A_Index%
	}
	Loop, %Array0%	;lägger till "|" för att DropDownList ska fungera
		Options .= Array%A_Index% . "|"

	FileRead, schemaid, currentid
	if errorlevel = 1
		MsgBox, File not found!
	Gui, new,+border +maximizebox +resize, Schema
	; Gui, -Caption
	; Gui, Margin, 0, 0
	Gui, Add, Edit, r1 vNewID  y0, Nytt Schema ID
	Gui, Add, Button,  y-1 gSpara Default, Spara
	Gui,Add,DropDownList,gChangeID  vNewChangeID y0,%Options%
	Gui, Add, Text, y0 ,% "Vecka   ", 5    
	Gui, Add, edit, y0, %vecka%
	Gui, Add, UpDown, y0 vVeckaUpDown gupdateraVecka range1-52, %vecka%

	UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=%vecka%&mode=0&printer=1&colors=1&head=1&clock=1&foot=1&day=0&width=1367&height=700&count=1&decrypt=0, Schema.png
	Gui, Add, Picture,x0 vschema,Schema.png

	Gui, Show,Maximize
	loop
	{
		ControlGetFocus, x, Schema,,,schema.png
		if (x= ""){
			Gui, destroy
			return
		}
	}
}
updateraVecka:
	Gui, submit, NoHide
	vecka :=VeckaUpDown
	UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=%vecka%&mode=0&printer=1&colors=2&head=1&clock=1&foot=1&day=0&width=1366&height=700&count=1&decrypt=0, Schema.png
	Guicontrol,, Schema,Schema.png
return


Spara:
	if(NewID != "Nytt Schema ID"){
		Gui, submit, NoHide
	File := FileOpen("currentid","w")
	File.write(NewID)
	File.close()
	File := FileOpen("id", "a")
	temp = %NewID%`n 
	File.write(temp)	
	File.close()
	schemaid := NewID
	Guicontrol,,NewChangeID,%NewID%
	Guicontrol,,NewID,
	UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=14&mode=0&printer=1&colors=1&head=1&clock=1&foot=1&day=0&width=1366&height=700&count=1&decrypt=0, Schema.png
	Guicontrol,, Schema,Schema.png
}
return

NewID:

return

ChangeID:
	Gui,submit, NoHide
	if (NewChangeID = "välj id"){
		; Gui,destroy
	}
	else
	{
		File := FileOpen("currentid", "w")
		File.Write(NewChangeID)
		File.Close()
		schemaid = %NewChangeID%
		;Gui,destroy
		UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=14&mode=0&printer=0&colors=1&head=1&clock=1&foot=1&day=0&width=1366&height=700&count=1&decrypt=0, Schema.png
		Guicontrol,, Schema,Schema.png
	}
	;OpenSchema()
return

matsedel:
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
	p = 1
	while p {
		p := InStr(x,"<")
		q := InStr(x,">")
		i := q - p + 1
		y := SubStr(x, p, i)
		StringReplace, x, x, % y ,`n,1
	}

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
	gui, add, button, gcloseMenu default y0, OK
	gui, show, autosize
return
closeMenu:
gui, destroy
return