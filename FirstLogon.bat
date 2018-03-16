REM The ping below is to simulate a sleep for 30 seconds
REM I found that unless the script waited until some of the first logon stuff finished it didn't work well
REM This is a very sloppy way of doing things and should be improved later
ping localhost -n 30 >NUL
taskkill /f /im explorer.exe
powershell.exe -ExecutionPolicy Bypass -File "C:\Scripts\SyncAndRedirect.ps1"
start explorer