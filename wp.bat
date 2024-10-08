xcopy h:Download\p.jpg C:\Users\smatkovich\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper /y
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f
xcopy h:\\Desktop\shutdown.lnk "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\" /y
xcopy h:\\Desktop\reboot.lnk "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\" /y
xcopy h:\\Desktop\logoff.lnk "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\" /y
