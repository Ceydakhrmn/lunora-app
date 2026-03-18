@echo off
cd /d "%~dp0"
echo Building Windows release app...
flutter build windows --release
if %errorlevel% equ 0 (
    echo.
    echo Build successful!
    echo Starting app...
    start "" "build\windows\x64\runner\Release\adet_dongusu.exe"
) else (
    echo Build failed!
    pause
)
