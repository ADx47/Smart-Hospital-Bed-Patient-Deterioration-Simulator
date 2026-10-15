@echo off
set "PATH=C:\Users\admin\node;C:\Users\admin\AppData\Local\Programs\Orange;C:\Users\admin\AppData\Local\Programs\Orange\Scripts;%PATH%"
cd /d "%~dp0frontend"
echo ========================================================
echo Starting MONSTER MIND Hospital Digital Twin Frontend...
echo Vite Development Server on http://localhost:5173
echo ========================================================
npm run dev -- --host
pause
