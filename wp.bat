xcopy h:Download\p.jpg C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper /y
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
xcopy h:\\Desktop\wp.bat.lnk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" /y
winget install -h --accept-package-agreements --accept-source-agreements 9NQ8Q8J78637
xcopy h:\\Desktop\sdrl.ahk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" /y
