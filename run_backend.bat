@echo off
set "PATH=C:\Users\admin\node;C:\Users\admin\AppData\Local\Programs\Orange;C:\Users\admin\AppData\Local\Programs\Orange\Scripts;%PATH%"
cd /d "%~dp0backend"
echo ========================================================
echo Starting MONSTER MIND Hospital Digital Twin Backend...
echo FastAPI REST API & WebSocket on http://127.0.0.1:8000
echo ========================================================
python -m uvicorn main:app --host 127.0.0.1 --port 8000 --reload
pause
