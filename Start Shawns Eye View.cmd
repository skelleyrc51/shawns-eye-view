@echo off
cd /d "%~dp0"
title Shawn's Eye View
echo === Shawn's Eye View ===
where node >nul 2>&1 || (echo Node.js not found. Install Node 24+ from https://nodejs.org and rerun. & pause & exit /b 1)
for /f "delims=" %%v in ('node -v') do echo Node %%v detected (need v24 or v26).
if not exist node_modules (echo Installing dependencies... & call npm ci || (pause & exit /b 1))
echo.
echo Starting server... (this window must stay open while you use the app)
echo Log: launch.log
echo.
start "" /b cmd /c "npm run dev > launch.log 2>&1"
set /a tries=0
:waitloop
timeout /t 1 /nobreak >nul
set /a tries+=1
findstr /c:"Local:" launch.log >nul 2>&1 && goto ready
findstr /i /c:"error" launch.log >nul 2>&1 && goto failed
if %tries% lss 45 goto waitloop
:failed
echo.
echo Server did not come up. Output:
echo ----------------------------------------
type launch.log
echo ----------------------------------------
pause
exit /b 1
:ready
set URL=http://localhost:4173/
echo Server ready at %URL%
start "" %URL%
echo.
echo Close this window (or press Ctrl+C) to stop the server.
type launch.log
:tail
timeout /t 5 /nobreak >nul
goto tail
