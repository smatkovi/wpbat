xcopy h:Download\p.jpg C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper /y
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
cd C:\Users\smatkovich\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch
mkdir "User Pinned\TaskBar\"
xcopy h:\\Desktop\shutdown.lnk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\" /y
xcopy h:\\Desktop\reboot.lnk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\" /y
xcopy h:\\Desktop\logoff.lnk "C:\Users\smatkovich\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\" /y
