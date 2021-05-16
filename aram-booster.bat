@echo off & setlocal

:: Check admin privileges
net SESSION 1>nul 2>nul
if %errorlevel% NEQ 0 goto :err

:: Get commandline of LeagueClientUx
for /F "tokens=* USEBACKQ" %%a in (
    `"WMIC PROCESS WHERE name='LeagueClientUx.exe' GET commandline | findstr ."`
) do set "cmdline=%%a"

:: Split commandline by space
for %%a in (%cmdline%) do (
    :: Split arguments by "="
    for /f "tokens=1,2 delims==" %%i in (%%a) do (
        :: Get app port
        if "%%i"=="--app-port" (
            set "port=%%j"
        )
        :: Get auth token (pass)
        if "%%i"=="--remoting-auth-token" (
            set "pass=%%j"
        )
    )
)

echo\

:: Check if port is not defined
if not defined port goto :err

:: Request to LCU and get response
for /f "tokens=* USEBACKQ" %%a in (
    `curl -s -g -k -X POST -u riot:%pass% ^
        https://127.0.0.1:%port%/lol-login/v1/session/invoke ^
        -d "destination=lcdsServiceProxy" ^
        -d "method=call" ^
        -d "args=["""",""teambuilder-draft"",""activateBattleBoostV1"",""""]"`
) do set resp=%%a

:: curl options:
:: -s   : silent mode
:: -g   : to use brackets in URL
:: -k   : allow insecure connection

set success={"body"

:: Check response
if defined %resp% (
    :: Success?
    if "%resp:~0,7%"=="%success%" (
        color A
        echo Your game is BOOSTED!
        goto :end
    )
)

:err
echo Failed to boost!
echo Please make sure League Client is opened,
echo    and run script again as Administrator.

:end
timeout /t 5 /nobreak

endlocal