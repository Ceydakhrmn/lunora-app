@echo off
cd /d "%~dp0"
set LOG_FILE=run_android.log
echo ==== %DATE% %TIME% ==== > %LOG_FILE%
flutter run -d emulator-5554 >> %LOG_FILE% 2>&1
type %LOG_FILE%
pause
