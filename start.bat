@echo off
chcp 65001 >nul
cd /d "%~dp0"
title my-clip-tool 로컬 서버

echo ============================================
echo   영상 편집 툴 - 로컬 서버 시작
echo   (이 창을 닫으면 서버가 종료됩니다)
echo ============================================
echo.

REM 1) Node 가 있으면 http-server 로 실행 (브라우저 자동 오픈)
where node >nul 2>nul
if %errorlevel%==0 (
  echo [Node 발견] http-server 로 http://localhost:8000 실행...
  echo.
  npx --yes http-server -p 8000 -c-1 -o
  goto end
)

REM 2) Node 가 없으면 Python 으로 실행
where python >nul 2>nul
if %errorlevel%==0 (
  echo [Python 발견] http://localhost:8000 실행 후 브라우저를 엽니다...
  echo.
  start "" "http://localhost:8000/index.html"
  python -m http.server 8000
  goto end
)

REM 3) py 런처 시도
where py >nul 2>nul
if %errorlevel%==0 (
  echo [Python(py) 발견] http://localhost:8000 실행 후 브라우저를 엽니다...
  echo.
  start "" "http://localhost:8000/index.html"
  py -m http.server 8000
  goto end
)

echo.
echo [오류] Node.js 또는 Python 이 필요합니다.
echo  - Node:   https://nodejs.org
echo  - Python: https://www.python.org/downloads/
echo 둘 중 하나를 설치한 뒤 이 파일을 다시 더블클릭하세요.
echo.
pause

:end
