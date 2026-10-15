@echo off
set "PATH=C:\Users\admin\node;C:\Users\admin\AppData\Local\Programs\Orange;C:\Users\admin\AppData\Local\Programs\Orange\Scripts;%PATH%"
cd /d "%~dp0backend"
echo ========================================================
echo Running Backend Unit Tests (Pytest)...
echo ========================================================
pytest -v
pause
