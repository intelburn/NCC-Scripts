ECHO off
::Set the path to where you are syncing after the equal sign, but inside the quotes
set SYNC=""
goto GetDrive

:GetDrive
::Prompt user for drive letter to use
set /p DRIVE=Enter the drive to copy the message onto:
::Check for valid input
if "%DRIVE%"=="" goto GetDrive
::do not clobber C:\
if /i "%DRIVE%" EQU "C" goto GetDrive
if not exist %DRIVE%:\ goto GetDrive
goto CopySync

:CopySync
if not exist %DRIVE%:\_sync\ mkdir %DRIVE%:\_sync
del /s /q %DRIVE%:\_sync\*
cls
robocopy %SYNC% %DRIVE%:\_sync\ /xd ".sync" /xf ".*" /e
echo Done
goto :eof