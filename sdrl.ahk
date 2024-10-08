; AutoHotkey script to handle Win + 1, Win + 2, Win + 3, and Win + 4 shortcuts

; Win + 1 to run Firefox Portable
#1::
Run, \\schulserver\SMATKOVICH$\Download\FirefoxPortable\FirefoxPortable.exe
return

; Win + 2 to Shutdown
#2::
Run, shutdown /s /t 0 /f
return

; Win + 3 to Restart
#3::
Run, shutdown /r /t 0 /f
return

; Win + 4 to Logoff
#4::
Run, logoff
return
