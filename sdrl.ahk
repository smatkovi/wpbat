; AutoHotkey v2 script - Hotkeys mit Firefox-Profil-Sync

; Win + 1 to run Firefox (installiertes Firefox bevorzugt, sonst Portable)
#1:: {
    if FileExist("C:\Program Files\Mozilla Firefox\firefox.exe")
        Run("C:\Program Files\Mozilla Firefox\firefox.exe")
    else
        Run("I:\Download\FirefoxPortable\FirefoxPortable.exe")
}

; Hilfsfunktion: Firefox-Profil sichern bevor System heruntergefahren wird
BackupAndRun(command) {
    ; Firefox beenden
    try {
        ProcessClose("firefox.exe")
        Sleep(2000)
    }
    ; Profil-Backup ausfuehren
    RunWait("I:\Download\firefox-sync.bat backup",, "Hide")
    ; Aktion ausfuehren
    Run(command)
}

; Win + 2 to Shutdown (mit Backup)
#2:: {
    BackupAndRun("shutdown /s /t 0 /f")
}

; Win + 3 to Restart (mit Backup)
#3:: {
    BackupAndRun("shutdown /r /t 0 /f")
}

; Win + 4 to Logoff (mit Backup)
#4:: {
    BackupAndRun("shutdown /l")
}

; Fange auch WM_QUERYENDSESSION ab (falls System anders heruntergefahren wird)
OnMessage(0x0011, QueryEndSession)

QueryEndSession(wParam, lParam, msg, hwnd) {
    RunWait("I:\Download\firefox-sync.bat backup",, "Hide")
    return true
}
