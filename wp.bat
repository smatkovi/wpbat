@echo off
REM === Wallpaper & System Settings ===
xcopy i:\\Download\p.jpg C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper /y
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
xcopy i:\\Desktop\wp.bat.lnk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" /y

REM === Install AutoHotkey from MS Store ===
winget install -h --accept-package-agreements --accept-source-agreements --source msstore --id=9PLQFDG8HH9D
xcopy i:\\Download\sdrl.ahk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" /y
timeout /t 5 /nobreak >nul
start "" i:\\Download\sdrl.ahk

REM === Install Mozilla Firefox ===
winget install -h --accept-package-agreements --accept-source-agreements Mozilla.Firefox

REM === Firefox Extensions via policies.json ===
REM Erst lokal kopieren (I:\ verfuegbar), dann als Admin nach Program Files
copy /y i:\\Download\policies.json "%TEMP%\policies.json" >nul
powershell -Command "Start-Process cmd -ArgumentList '/c mkdir \"C:\Program Files\Mozilla Firefox\distribution\" 2>nul & copy /y \"%TEMP%\policies.json\" \"C:\Program Files\Mozilla Firefox\distribution\policies.json\"' -Verb RunAs -Wait"

REM === Restore Firefox Profile from I: Drive ===
call i:\\Download\firefox-sync.bat restore
