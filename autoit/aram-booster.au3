#RequireAdmin
#include <Constants.au3>
#include <String.au3>
#include "_HttpRequest.au3"

; Check for admin permission
if not IsAdmin() then
	MsgBox(0, 'Aram-Booster', 'Please reopen program as an Administrator!')
    Exit
endIf

; Constants
local const $sHost = '127.0.0.1'
local const $sProc = 'LeagueClientUx.exe'

; Get LCU process ID
local $iPID = ProcessExists($sProc)

; Check if process does not exist
if $iPID == 0 then
    MsgBox(0, 'Aram-Booster', 'Please make sure League Client is opened!')
	Exit
endIf

; Execute WMIC commandline query
local $iWmicPID = Run("WMIC PROCESS WHERE name='" & $sProc & "' GET commandline", '', @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
ProcessWaitClose($iWmicPID)
; Read stdout
local $sCmdLine = StdoutRead($iWmicPID)

; What stuff?
if StringInStr($sCmdLine, $sProc) == 0 Then
	MsgBox(0, 'Aram-booster', 'Failed to connect to League Client, please try again!')
	Exit
endIf

local $tmp
local $sPort, $sPass

; Get app port
$tmp = StringInStr($sCmdLine, '--app-port')
$sPort = _StringBetween(StringMid($sCmdLine, $tmp), '=', '"')[0]

; Get auth token (pass)
$tmp = StringInStr($sCmdLine, '--remoting-auth-token')
$sPass = _StringBetween(StringMid($sCmdLine, $tmp), '=', '"')[0]

; Create URL
local $sUrl = 'https://riot:' & $sPass & '@' & $sHost & ':' & $sPort & _
	'/lol-login/v1/session/invoke?' & _
	'destination=lcdsServiceProxy&' & _
	'method=call&args=["","teambuilder-draft","activateBattleBoostV1",""]'

; Make POST request
local $sRes = _HttpRequest(2, $sUrl, '', '', '', '', 'POST')

; Check response
if StringInStr($sRes, '{"body"') <> 0 Then
	; Success
	MsgBox(0, 'Aram-Booster', 'Your game is BOOSTED, enjoy :)')
else
	MsgBox(0, 'Aram-Booster', 'Failed to boost, please try again :(')
endIf