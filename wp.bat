@echo off
REM === Admin-Rechte anfordern ===
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

REM === Netzlaufwerke neu mappen (gehen bei RunAs verloren) ===
if not exist I:\ net use I: \\nas1\home /persistent:no >nul 2>&1

REM === Wallpaper & System Settings ===
xcopy i:\\Download\p.jpg C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper /y
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
xcopy i:\\Desktop\wp.bat.lnk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" /y

REM === Install AutoHotkey from MS Store ===
winget install -h --accept-package-agreements --accept-source-agreements --source msstore --id=9PLQFDG8HH9D
xcopy i:\\Download\sdrl.ahk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" /y
i:\\Download\sdrl.ahk

REM === Install Mozilla Firefox ===
winget install -h --accept-package-agreements --accept-source-agreements Mozilla.Firefox

REM === Firefox Extensions via policies.json (mit Admin moeglich) ===
set "FF_DIST=C:\Program Files\Mozilla Firefox\distribution"
if not exist "%FF_DIST%" mkdir "%FF_DIST%"
xcopy i:\\Download\policies.json "%FF_DIST%\" /y

REM === Restore Firefox Profile from I: Drive ===
call i:\\Download\firefox-sync.bat restore
