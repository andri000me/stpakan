;Example program showing how to use some of the commMg3.au3 UDF functions
;this example is a very simple terminal
;Version 2 26th July 2006
;changes-
;change flow control checkbox to combo and add NONE
;correct error in call to _CommSetPort - stop bits were missing which meant th eflow control was used for stop bits

#include <GUIConstantsEx.au3>
#include 'CommMG.au3';or if you save the commMg.dll in the @scripdir use #include @SciptDir & '\commmg.dll'
#include <GuiEdit.au3>
#include <GuiComboBox.au3>
#include <windowsconstants.au3>
#include <buttonconstants.au3>
#Include <Array.au3>


Opt("WINTITLEMATCHMODE", 3)
OnAutoItExitRegister("alldone")
HotKeySet("{ESC}", "alldone")

$result = '';used for any returned error message setting port
Const $settitle = "COMMG Example - set Port", $maintitle = "COMMG Example"
$setflow = 2;default to no flow control
Dim $FlowType[3] = ["XOnXoff", "Hardware (RTS, CTS)", "NONE"]
#Region main program
#cs mine
#Region ### START Koda GUI section ### Form=d:\my documents\miscdelphi\commg\ExampleComm.kxf
$Form2 = GUICreate("COMMG Example", 473, 349, 339, 333, BitOR($WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_THICKFRAME, $WS_SYSMENU, $WS_CAPTION, $WS_OVERLAPPEDWINDOW, $WS_TILEDWINDOW, $WS_POPUP, $WS_POPUPWINDOW, $WS_GROUP, $WS_TABSTOP, $WS_BORDER, $WS_CLIPSIBLINGS))
$Edit1 = GUICtrlCreateEdit("", 10, 25, 449, 223, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_READONLY, $ES_WANTRETURN, $WS_HSCROLL, $WS_VSCROLL))
$BtnSend = GUICtrlCreateButton("Send", 380, 273, 53, 30, $BS_FLAT)
$Input1 = GUICtrlCreateInput("", 18, 279, 361, 21)
$Checkbox1 = GUICtrlCreateCheckbox("Add LF to incomming CR", 273, 4, 145, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetResizing(-1, $GUI_DOCKAUTO)
$Label11 = GUICtrlCreateLabel("Text to send", 24, 261, 63, 17)
$BtnSetPort = GUICtrlCreateButton("Set Port", 16, 312, 73, 30, $BS_FLAT)
$Label21 = GUICtrlCreateLabel("Received text", 34, 6, 70, 17)
$Label31 = GUICtrlCreateLabel("commg.dll version unknown", 272, 328, 135, 17)
GUICtrlSetColor(-1, 0x008080)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
WinSetTitle($Form2, "", $maintitle & "  UDF = " & _CommGetVersion(1))
#ce

While setport(0) = -1
    If MsgBox(4, 'Port not set', 'Do you want to quite the program?') = 6 Then Exit
WEnd


;GUISwitch($Form2)
ConsoleWrite("stage 1" & @CRLF)
;;GUICtrlSetData($Label31, 'using ' & _CommGetVersion(1))
ConsoleWrite("stage 2" & @CRLF)
;Events()

;;GUICtrlSetState($Edit1, $GUI_FOCUS)


;; -------------------------

$app='S T R U K � T I M B A N G - Mozilla Firefox'
$myapp='Timbangan'


GUICreate($myapp,270,140)
$input=GUICtrlCreateInput('',10,10,250,80)
GUICtrlSetState($input,$GUI_DISABLE)
GUICtrlSetFont($input,50,700)
$kirim=GUICtrlCreateButton("Kirim", 140,95,120,40)
GUICtrlSetFont($kirim,20,700)
GUISetState()
$handle_timbang=0

If WinExists($app) Then
	;MsgBox(0,'','Program aktif')
	$handle_timbang=WinActivate($app)
	Sleep(100)
	WinActivate($myapp)	
EndIf


$i=0
$str=0
GUISetState() ; will display an empty dialog box
WinSetOnTop($myapp, "", 1)

While 1
	;gets characters received returning when one of these conditions is met:
    ;receive @CR, received 20 characters or 200ms has elapsed
    $instr = _CommGetString()
    If $instr <> '' Then;if we got something		
		;$str = StringRegExpReplace($instr,"[^0-9.\s]","")
		$str = StringMid(StringRegExpReplace($instr,"[^0-9.\s]",""),2,7)
		;ConsoleWrite($str)		
		;$str=StringLeft($str,6) & '.' & StringMid($str,7)
		
		If (StringLeft($str,1))<>' ' Then
			;ConsoleWrite('Yao ...' & @crlf)
		Else
			;$str1 = StringMid(StringRegExpReplace($str,"[^0-9.\s]",""),2,7)
			$str=StringReplace($str,' ','')
			GUICtrlSetData($input,$str)
			;ConsoleWrite("'" & $str & "'" & @crlf)
		EndIf		
		
		Sleep(100)	
    EndIf
	$msg = GUIGetMsg()
	If $msg=$kirim Then 
		kirimData()
		$msg=0;
	EndIf

WEnd
GUIDelete()
Alldone()

Func kirimData()
	$handle_timbang=WinActivate($app)
	If $handle_timbang=0 Then
		MsgBox(0,'','Program timbangan tidak aktif')
	EndIf
	;Sleep(100)
	;Send($str)
	ClipPut($str)
	Sleep(50)
	Send("+{INS}")
	Send("{TAB}")
EndFunc

Func port11()
    ;MsgBox(0,'now set to channel',_CommSwitch(2))
    _commSwitch(2)
    $s2 = "1 2 3 4";_CommGetString()
    ConsoleWrite("comm1 gets " & $s2 & @CRLF)
    _CommSendString($s2)
    _CommSwitch(1)

EndFunc   ;==>port11

#EndRegion main program
Func Events()
    Opt("GUIOnEventMode", 1)
    GUISetOnEvent($GUI_EVENT_CLOSE, "justgo")
    ;;GUICtrlSetOnEvent($BtnSend, "SendEvent")
    ;;GUICtrlSetOnEvent($BtnSetPort, "SetPortEvent")
EndFunc   ;==>Events

Func SetPortEvent()
    setport();needed because a parameter is optional for setport so we can't use "setport" for the event
    ;;GUICtrlSetState($Edit1, $GUI_FOCUS)
EndFunc   ;==>SetPortEvent

Func justgo()
    Exit
EndFunc   ;==>justgo

Func SendEvent();send the text in the inputand append CR
    ;;_CommSendstring(GUICtrlRead($Input1) & @CR)
    ;;GUICtrlSetData($Input1, '');clear the input
    ;GUICtrlSetState($edit1,$GUI_FOCUS);sets the caret back in the terminal screen
EndFunc   ;==>SendEvent


Func AllDone()
    ;MsgBox(0,'will close ports','')
    _Commcloseport()
    ;MsgBox(0,'port closed','')
    Exit
EndFunc   ;==>AllDone


; Function SetPort($mode=1)
; Creates a form for the port settings
;Parameter $mode sets the return value depending on whether the port was set
;Returns  0 if $mode <> 1
;          -1 If` the port not set and $mode is 1
Func SetPort($mode = 1);if $mode = 1 then returns -1 if settings not made

    Opt("GUIOnEventMode", 0);keep events for $Form2, use GuiGetMsg for $Form3

    #Region ### START Koda GUI section ### Form=d:\my documents\miscdelphi\commg\examplecommsetport.kxf
    $Form3 = GUICreate("COMMG Example - set Port", 422, 279, 329, 268, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_GROUP, $WS_BORDER, $WS_CLIPSIBLINGS, $DS_MODALFRAME), BitOR($WS_EX_TOPMOST, $WS_EX_WINDOWEDGE))
    $Group1 = GUICtrlCreateGroup("Set COM Port", 18, 8, 288, 252)
    $CmboPortsAvailable = GUICtrlCreateCombo("", 127, 28, 145, 25)
    $CmBoBaud = GUICtrlCreateCombo("19200", 127, 66, 145, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $CBS_SORT, $WS_VSCROLL))
    GUICtrlSetData(-1, "10400|110|115200|1200|128000|14400|150|15625|1800|2000|2400|256000|28800|3600|38400|4800|50|56000|57600|600|7200|75|9600")
    $CmBoStop = GUICtrlCreateCombo("1", 127, 141, 145, 25)
    GUICtrlSetData(-1, "1|2|1.5")
    $CmBoParity = GUICtrlCreateCombo("none", 127, 178, 145, 25)
    GUICtrlSetData(-1, "odd|even|none")
    $Label2 = GUICtrlCreateLabel("Port", 94, 32, 23, 17)
    $Label3 = GUICtrlCreateLabel("baud", 89, 70, 28, 17)
    $Label4 = GUICtrlCreateLabel("No. Stop bits", 52, 145, 65, 17)
    $Label5 = GUICtrlCreateLabel("parity", 88, 182, 29, 17)
    $CmboDataBits = GUICtrlCreateCombo("8", 127, 103, 145, 25)
    GUICtrlSetData(-1, "7|8")
    $Label7 = GUICtrlCreateLabel("No. of Data Bits", 38, 107, 79, 17)
    $ComboFlow = GUICtrlCreateCombo("NONE", 127, 216, 145, 25)
    GUICtrlSetData(-1, "NONE|XOnXOff|Hardware (RTS, CTS)")
    $Label1 = GUICtrlCreateLabel("flow control", 59, 220, 58, 17)
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    $BtnApply = GUICtrlCreateButton("Apply", 315, 95, 75, 35, $BS_FLAT)
    GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
    $BtnCancel = GUICtrlCreateButton("Cancel", 316, 147, 76, 35, $BS_FLAT)
    GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
    GUISetState(@SW_SHOW)
    #EndRegion ### END Koda GUI section ###


    WinSetTitle($Form3, "", $settitle);ensure a change to Koda design doesn't stop script working
    ;;$mainxy = WinGetPos($Form2)
    ;;WinMove($Form3, "", $mainxy[0] + 20, $mainxy[1] + 20)
    ;$set = _CommSetport(1,$result,9600,8,0,1,0)
    ;help
    ;send /rcv
    ;
    $portlist = _CommListPorts(0);find the available COM ports and write them into the ports combo
    If @error = 1 Then
        MsgBox(0, 'trouble getting portlist', 'Program will terminate!')
        Exit
    EndIf


    For $pl = 1 To $portlist[0]
        GUICtrlSetData($CmboPortsAvailable, $portlist[$pl]);_CommListPorts())
    Next
    GUICtrlSetData($CmboPortsAvailable, $portlist[1]);show the first port found
    GUICtrlSetData($ComboFlow, $FlowType[$setflow])
    _GUICtrlComboBox_SetMinVisible($CmBoBaud, 10);restrict the length of the drop-down list

    $retval = 0

    #cs mine
	While 1
        $msg = GUIGetMsg()
        If $msg = $BtnCancel Then
            If Not $mode Then $retval = -1
            ExitLoop
        EndIf


        If $msg = $BtnApply Then
	#ce
            Local $sportSetError
            $comboflowsel = GUICtrlRead($ComboFlow)
            For $n = 0 To 2
                If $comboflowsel = $FlowType[$n] Then
                    $setflow = $n
                    ConsoleWrite("flow = " & $setflow & @CRLF)
                    ExitLoop
                EndIf

            Next
            $setport = StringReplace(GUICtrlRead($CmboPortsAvailable), 'COM', '')
            _CommSetPort($setport, $sportSetError, GUICtrlRead($CmBoBaud), GUICtrlRead($CmboDataBits), GUICtrlRead($CmBoParity), GUICtrlRead($CmBoStop), $setflow)
            if $sportSetError = '' Then
	;;			MsgBox(262144, 'Connected ','to COM' & $setport)
			Else
				MsgBox(262144, 'Setport error = ', $sportSetError)
				$retval=-1 ;;mine
			EndIf
            $mode = 1;
    ;;        ExitLoop
    ;;    EndIf

        ;stop user switching back to $form2
        If WinActive($maintitle) Then
            ConsoleWrite('main is active' & @CRLF)
            If WinActivate($settitle) = 0 Then MsgBox(0, 'not found', $settitle)
        EndIf


    ;;WEnd
    Sleep(500)
	GUIDelete($Form3)
    WinActivate($maintitle)
    ;Events()
    Return $retval


EndFunc   ;==>SetPort
