@echo off
cd /d "%~dp0"
echo === Shawn's Eye View setup ===
where node >nul 2>&1 || (echo Node.js not found. Install Node 24+ from https://nodejs.org and rerun. & pause & exit /b 1)
for /f "tokens=1 delims=." %%v in ('node -v') do set NODEMAJ=%%v
echo Node %NODEMAJ% detected (need v24 or v26).
if not exist node_modules (echo Installing dependencies... & call npm ci || (pause & exit /b 1))
call npm run doctor
echo.
echo Starting dev server -- open http://localhost:4173 in your browser. Ctrl+C to stop.
start "" http://localhost:4173
call npm run dev
pause
