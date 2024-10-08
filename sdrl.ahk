; AutoHotkey script to handle Win + 2, Win + 3, and Win + 4 shortcuts

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
