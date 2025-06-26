xcopy i:\\Download\p.jpg C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper /y
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
xcopy i:\\Desktop\wp.bat.lnk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" /y
winget install -h --accept-package-agreements --accept-source-agreements --source msstore --id=9PLQFDG8HH9D
xcopy i:\\Download\sdrl.ahk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" /y
"C:\Program Files\AutoHotkey\AutoHotkey.exe" /install
i:\\Download\sdrl.ahk
