#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
MsgBox, RosenHotkey hars startat!


secretkey = JS94IX75JS62JE65LY02QA16TV23

!s::	;Öppna schema
OpenSchema()
return

!1::	;The following code is to create hotkeys to hyperlinks
linkShortcut("alt1")
return	
!2::
linkShortcut("alt2")
return
!3::
linkShortcut("alt3")
return
!4::
linkShortcut("alt4")
return
!5::
linkShortcut("alt5")
return
!6::
linkShortcut("alt6")
return
!7::
linkShortcut("alt7")
return
!8::
linkShortcut("alt8")
return
!9::
linkShortcut("alt9")
return

!m::
; Create the array, initially empty:
Loop, %Array0%
	Array%A_Index% := ""
Options := ""
Array := Object()
loop, read, %A_ScriptDir%\id
{
	Array%A_index% := A_LoopReadLine
	Array0 = %A_Index%
}
Loop, %Array0%
	Options .= Array%A_Index% . "|"

;Array:=[]
;loop, Array.Length()
;	Array[A_index] := ""
;	
;loop, read, C:\Rosenschema\id
;	Array[A_index]:=A_LoopReadLine
;loop, Array.Length()
;	Options .= Array[A_Index] . "|"
	
GUI,New,+Resize +MinSize640x480,Menu
Gui,Add,DropDownList,vNewid,%Options%
Gui,Show
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

OpenSchema()
{
global
; Create the array, initially empty:
Loop, %Array0%
	Array%A_Index% := ""
Options := ""
Array := Object()	;new array
loop, read, %A_ScriptDir%\id	;puts every line of the file into Array
{
	Array%A_index% := A_LoopReadLine
	Array0 = %A_Index%
}
Loop, %Array0%	;lägger till "|" för att DropDownList ska fungera
	Options .= Array%A_Index% . "|"
SysGet, Mon1, MonitorWorkArea
WorkWidth := (Mon1Right)-(Mon1Left)
WorkHeight := (Mon1Bottom)- (Mon1Top)
FileRead, schemaid, currentid
if errorlevel = 1
MsgBox, File not found!
Gui, new,, Schema
Gui, -border
Gui, Margin, 0, 0
Gui, Add, Edit, r1 vNewID  y0, Nytt Schema ID
Gui, Add, Button,  y-1 gSpara Default, Spara
Gui,Add,DropDownList,gChangeID  vNewChangeID y0,välj id||%Options%

yearweek = A_Yweek
StringRight, week, yearweek, 2
SchemaWidth := (WorkWidth-5) ;adjusting size to fit the whole schedule inside the GUI window.
SchemaHeight := (WorkHeight-41)
UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=%week%&mode=0&printer=0&colors=2&head=1&clock=1&foot=1&day=0&width=%SchemaWidth%&height=%SchemaHeight%&count=1&decrypt=0, Schema.png
Gui, Add, Picture,x0,Schema.png
Gui, Add, text, x(%WorkWidth%/2), Tryck "alt Tab" för att gå ur schemat!

Gui, Show, xCenter y%Mon1Top%
loop
{
	ControlGetFocus, x, Schema,,,schema.png
	if (x= ""){
		Gui, destroy
		return
	}
}
}
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
UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=%week%&mode=0&printer=0&colors=2&head=1&clock=1&foot=1&day=0&width=1366&height=700&count=1&decrypt=0, Schema.png
Guicontrol,, Schema,Schema.png
}
return

NewID:

return

ChangeID:
Gui,submit, NoHide
if (NewChangeID = "välj id"){
Gui,destroy
}else{
File := FileOpen("currentid", "w")
File.Write(NewChangeID)
File.Close()
schemaid = %NewChangeID%
;Gui,destroy
UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=14&mode=0&printer=0&colors=2&head=1&clock=1&foot=1&day=0&width=1366&height=700&count=1&decrypt=0, Schema.png
Guicontrol,, Schema,Schema.png
}
;OpenSchema()
return
