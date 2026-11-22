@echo off
echo Starting CropDNA Platform Services...
echo.

set PYTHON=C:\Users\LOQ\AppData\Local\Programs\Python\Python312\python.exe
set NODE=C:\Users\LOQ\AppData\Local\ms-playwright-go\1.57.0\node.exe
set VITE=C:\Users\LOQ\Desktop\AgriCulture\AgriCulture-1.0.0\AgriCulture-1.0.0\client\node_modules\vite\bin\vite.js
set BACKEND=C:\Users\LOQ\Desktop\AgriCulture\AgriCulture-1.0.0\intglalasouhaboub2\intglalasouhaboub2
set RAGDIR=C:\Users\LOQ\Desktop\AgriCulture\cropdna
set CLIENT=C:\Users\LOQ\Desktop\AgriCulture\AgriCulture-1.0.0\AgriCulture-1.0.0\client

echo Freeing ports...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8000 " ^| findstr "LISTENING" 2^>nul') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":5007 " ^| findstr "LISTENING" 2^>nul') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":5173 " ^| findstr "LISTENING" 2^>nul') do taskkill /PID %%a /F >nul 2>&1
echo Ports cleared.
echo.

echo 1. Starting Main Backend (Port 8000)...
start "Main Backend (Port 8000)" cmd /k "cd /d %BACKEND% && %PYTHON% -m uvicorn main_combine:app --reload --host 0.0.0.0 --port 8000"

echo 2. Starting RAG Server (Port 5007)...
start "RAG Server (Port 5007)" cmd /k "cd /d %RAGDIR% && %PYTHON% -m uvicorn module7_server:app --port 5007"

echo 3. Starting React Frontend (Port 5173)...
start "React Frontend (Port 5173)" cmd /k "cd /d %CLIENT% && %NODE% %VITE% --host"

echo.
echo All services launched!
echo.
echo   Main Backend  : http://127.0.0.1:8000/docs
echo   RAG Server    : http://127.0.0.1:5007
echo   Frontend      : http://localhost:5173
echo.
pause
