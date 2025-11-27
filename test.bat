@echo off
color 0A
echo ================================
echo    BATCH FILE TEST SCRIPT
echo ================================
echo.
echo This is a test batch file!
echo.
echo Computer Name: %COMPUTERNAME%
echo Username: %USERNAME%
echo Current Date: %DATE%
echo Current Time: %TIME%
echo.
echo ================================
echo    SYSTEM INFORMATION
echo ================================
echo.

systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type"

echo.
echo ================================
echo.
echo Batch file executed successfully!
echo.
pause
