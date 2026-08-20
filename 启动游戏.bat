@echo off
cd /d "%~dp0"
echo Starting Touhou Music Quiz server...
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0server.ps1"
echo.
echo Server stopped. You can close this window now.
pause
