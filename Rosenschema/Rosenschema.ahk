#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
MsgBox, RosenHotkey hars startat!
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
!h::
OpenMenulinks()
return
OpenMenulinks()
{
global
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
}
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
Gui,Add,DropDownList,gChangeID  vNewChangeID y0,välj id||%Options%
Gui, Add, Text, y0 ,% "Vecka   ", 5    
Gui, Add, edit, y0, %vecka%
Gui, Add, UpDown, y0 vVeckaUpDown gupdateraVecka range1-52, %vecka%

UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=%vecka%&mode=0&printer=0&colors=2&head=1&clock=1&foot=1&day=0&width=1367&height=700&count=1&decrypt=0, Schema.png
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
UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=%vecka%&mode=0&printer=0&colors=2&head=1&clock=1&foot=1&day=0&width=1366&height=700&count=1&decrypt=0, Schema.png
Guicontrol,, Schema,Schema.png
return
MinskaVecka:
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
UrlDownloadToFile, http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=81320/sv-se&type=-1&id=%schemaid%&period=&week=14&mode=0&printer=0&colors=2&head=1&clock=1&foot=1&day=0&width=1366&height=700&count=1&decrypt=0, Schema.png
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

