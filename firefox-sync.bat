@echo off
REM firefox-sync.bat - Synchronisiert Firefox-Profil zwischen Installation und I:\
REM Usage: firefox-sync.bat backup | restore

set "FF_PROFILES=%APPDATA%\Mozilla\Firefox\Profiles"
set "BACKUP_DIR=I:\Download\FirefoxProfileBackup"
set "EXCLUDEDIRS=cache2 startupCache thumbnails crashes saved-telemetry-pings datareporting storage"
set "EXCLUDEFILES=parent.lock .parentlock favicons.sqlite"

if "%~1"=="backup" goto :backup
if "%~1"=="restore" goto :restore
echo Usage: firefox-sync.bat backup ^| restore
exit /b 1

:backup
REM Profil von installiertem Firefox nach I:\ sichern
if not exist "%FF_PROFILES%" (
    echo Firefox-Profilordner nicht gefunden, ueberspringe Backup.
    exit /b 0
)

REM Firefox beenden falls noch offen
taskkill /f /im firefox.exe >nul 2>&1
timeout /t 2 /nobreak >nul

REM Finde das Default-Profil
set "PROFILE_DIR="
for /d %%P in ("%FF_PROFILES%\*.default-release") do set "PROFILE_DIR=%%P"
if not defined PROFILE_DIR (
    for /d %%P in ("%FF_PROFILES%\*") do (
        if not defined PROFILE_DIR set "PROFILE_DIR=%%P"
    )
)

if not defined PROFILE_DIR (
    echo Kein Firefox-Profil gefunden.
    exit /b 0
)

if not exist "%BACKUP_DIR%" (
    echo Erstes Backup, kopiere Profil...
    mkdir "%BACKUP_DIR%"
    goto :do_backup
)

REM Trockenlauf: pruefen ob sich etwas geaendert hat
robocopy "%PROFILE_DIR%" "%BACKUP_DIR%" /mir /L /xd %EXCLUDEDIRS% /xf %EXCLUDEFILES% /njh /njs /ndl /nc /ns >nul 2>&1
if %errorlevel% lss 1 (
    echo Keine Aenderungen, ueberspringe Backup.
    exit /b 0
)

:do_backup
echo Sichere Profil: %PROFILE_DIR%
robocopy "%PROFILE_DIR%" "%BACKUP_DIR%" /mir /xd %EXCLUDEDIRS% /xf %EXCLUDEFILES% >nul 2>&1
echo Backup abgeschlossen.
exit /b 0

:restore
REM Profil von I:\ in installierten Firefox wiederherstellen
if not exist "%BACKUP_DIR%" (
    echo Kein Backup auf I:\ gefunden, ueberspringe Restore.
    exit /b 0
)

REM Warte bis Firefox-Profilordner existiert (nach Installation)
if not exist "%FF_PROFILES%" (
    REM Firefox einmal kurz starten damit Profil erstellt wird, dann beenden
    if exist "C:\Program Files\Mozilla Firefox\firefox.exe" (
        start "" "C:\Program Files\Mozilla Firefox\firefox.exe" -headless
        timeout /t 5 /nobreak >nul
        taskkill /f /im firefox.exe >nul 2>&1
        timeout /t 2 /nobreak >nul
    )
)

if not exist "%FF_PROFILES%" (
    echo Firefox-Profilordner existiert nicht.
    exit /b 0
)

REM Finde das Ziel-Profil
set "PROFILE_DIR="
for /d %%P in ("%FF_PROFILES%\*.default-release") do set "PROFILE_DIR=%%P"
if not defined PROFILE_DIR (
    for /d %%P in ("%FF_PROFILES%\*") do (
        if not defined PROFILE_DIR set "PROFILE_DIR=%%P"
    )
)

if not defined PROFILE_DIR (
    echo Kein Ziel-Profil gefunden.
    exit /b 0
)

echo Stelle Profil wieder her nach: %PROFILE_DIR%

robocopy "%BACKUP_DIR%" "%PROFILE_DIR%" /mir /xf parent.lock .parentlock >nul 2>&1

REM user.js fuer Cache-Minimierung deployen
call :deploy_userjs "%PROFILE_DIR%"

echo Restore abgeschlossen.
exit /b 0

:deploy_userjs
REM Erstellt user.js mit minimalen Cache-Einstellungen
set "USERJS=%~1\user.js"
echo // Firefox Cache + Temp Minimierung > "%USERJS%"
echo // Disk-Cache komplett deaktivieren >> "%USERJS%"
echo user_pref("browser.cache.disk.enable", false); >> "%USERJS%"
echo user_pref("browser.cache.disk.capacity", 0); >> "%USERJS%"
echo // Memory-Cache auf 32 MB limitieren >> "%USERJS%"
echo user_pref("browser.cache.memory.capacity", 32768); >> "%USERJS%"
echo // Offline-Cache deaktivieren >> "%USERJS%"
echo user_pref("browser.cache.offline.enable", false); >> "%USERJS%"
echo // Session-Restore minimieren >> "%USERJS%"
echo user_pref("browser.sessionstore.interval", 300000); >> "%USERJS%"
echo // Keine Crash-Reports >> "%USERJS%"
echo user_pref("browser.crashReports.unsubmittedCheck.enabled", false); >> "%USERJS%"
echo // Telemetry deaktivieren >> "%USERJS%"
echo user_pref("toolkit.telemetry.enabled", false); >> "%USERJS%"
echo user_pref("toolkit.telemetry.unified", false); >> "%USERJS%"
echo user_pref("datareporting.healthreport.uploadEnabled", false); >> "%USERJS%"
echo user_pref("datareporting.policy.dataSubmissionEnabled", false); >> "%USERJS%"
echo // Formular-Autofill deaktivieren >> "%USERJS%"
echo user_pref("extensions.formautofill.addresses.enabled", false); >> "%USERJS%"
echo user_pref("extensions.formautofill.creditCards.enabled", false); >> "%USERJS%"
exit /b 0
