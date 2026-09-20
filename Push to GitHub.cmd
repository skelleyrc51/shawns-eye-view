@echo off
cd /d "%~dp0"
echo === Pushing Shawn's Eye View to github.com/skelleyrc51/shawns-eye-view ===
echo A browser window may open asking you to sign in to GitHub -- approve it, then come back here.
git push -u origin main
if errorlevel 1 (echo. & echo Push failed -- see message above. & pause & exit /b 1)
echo.
echo Done! Your repo: https://github.com/skelleyrc51/shawns-eye-view
pause
