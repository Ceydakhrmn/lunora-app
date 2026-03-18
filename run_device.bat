@echo off
cd /d "%~dp0"
set LOG_FILE=run_device.log
echo ==== %DATE% %TIME% ==== > %LOG_FILE%
flutter run -d R58NC2PY4JL >> %LOG_FILE% 2>&1
type %LOG_FILE%
pause
