REM TODO: Take ownership of registry keys

@cls
@echo off
setlocal enableextensions

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\System32\cacls.exe" "%SYSTEMROOT%\System32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
color 03
title iTunes Removal Script
echo.
echo ===============================================
echo iTunes Removal Script
echo ===============================================
echo.
echo Press any key to run the script, or close
echo window to exit.
pause >nul 2>&1
echo Removing iTunes...
echo.

echo 1. Killing all running Apple tasks
for /f "skip=3 tokens=1" %%i in ('TASKLIST /FI "USERNAME eq %userdomain%\%username%" /FI "STATUS eq running"') do (
if "%%i"=="AppleMobileBackup.exe" (
if "%%i"=="AppleMobileDeviceHelper.exe" (
if "%%i"=="AppleMobileDeviceService.exe" (
if "%%i"=="AppleMobileSync.exe" (
if "%%i"=="AppleOutlookDAVConfig.exe" (
if "%%i"=="ApplePhotoStreams.exe" (
if "%%i"=="APSDaemon.exe" (
if "%%i"=="distnoted.exe" (
if "%%i"=="iCloud.exe" (
if "%%i"=="iCloudServices.exe" (
if "%%i"=="iPodService.exe" (
if "%%i"=="iTunes.exe" (
if "%%i"=="iTunesHelper.exe" (
if "%%i"=="iTunesPhotoProcessor.exe" (
if "%%i"=="MDCrashReportTool.exe" (
if "%%i"=="mDNSResponder.exe" (
if "%%i"=="qttask.exe" (
if "%%i"=="SyncServer.exe" (
if "%%i"=="YSLoader.exe" (
taskkill /f /t /im "%%i" >nul 2>&1
))))))))))))))))))))
echo.

echo 2. Attempting silent uninstall of known Apple software
if exist "%~dp0iTunes_Removal_Script.vbs" (
start "iTunesUninstall" /wait "%~dp0iTunesRemovalScript.vbs" >nul 2>&1
)
start /wait msiexec /qn /norestart /x {C2651553-6CA3-4822-B2E6-BC4ACA6E0EA2}
start /wait msiexec /qn /norestart /x {26356515-5821-40FA-9C3D-9785052A1062}
start /wait msiexec /qn /norestart /x {2E4AF2A6-50EA-4260-9BA4-5E582D11879A}
start /wait msiexec /qn /norestart /x {56DDDFB8-7F79-4480-89D5-25E1F52AB28F}
start /wait msiexec /qn /norestart /x {9F4BF859-C3A4-4AB6-BDD1-9C5D58188598}
start /wait msiexec /qn /norestart /x {56EC47AA-5813-4FF6-8E75-544026FBEA83}
echo.

echo 3. Taking ownership of all Apple files in all known possible locations
takeown /r /d y /f "%AppData%\Apple" >nul 2>&1
takeown /r /d y /f "%AppData%\Apple Computer" >nul 2>&1
takeown /r /d y /f "%AppData%\Apple Software Update" >nul 2>&1
takeown /r /d y /f "%AppData%\Bonjour" >nul 2>&1
takeown /r /d y /f "%AppData%\iPod" >nul 2>&1
takeown /r /d y /f "%AppData%\iTunes" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles%\Apple" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles%\Apple Computer" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles%\Apple Software Update" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles%\Bonjour" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles%\iPod" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles%\iTunes" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles(x86)%\Apple" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles(x86)%\Apple Computer" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles(x86)%\Apple Software Update" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles(x86)%\Bonjour" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles(x86)%\iPod" >nul 2>&1
takeown /r /d y /f "%CommonProgramFiles(x86)%\iTunes" >nul 2>&1
takeown /r /d y /f "%LocalAppData%\Apple" >nul 2>&1
takeown /r /d y /f "%LocalAppData%\Apple Computer" >nul 2>&1
takeown /r /d y /f "%LocalAppData%\Apple Software Update" >nul 2>&1
takeown /r /d y /f "%LocalAppData%\Bonjour" >nul 2>&1
takeown /r /d y /f "%LocalAppData%\iPod" >nul 2>&1
takeown /r /d y /f "%LocalAppData%\iTunes" >nul 2>&1
takeown /r /d y /f "%ProgramData%\Apple" >nul 2>&1
takeown /r /d y /f "%ProgramData%\Apple Computer" >nul 2>&1
takeown /r /d y /f "%ProgramData%\Apple Software Update" >nul 2>&1
takeown /r /d y /f "%ProgramData%\Bonjour" >nul 2>&1
takeown /r /d y /f "%ProgramData%\iPod" >nul 2>&1
takeown /r /d y /f "%ProgramData%\iTunes" >nul 2>&1
takeown /r /d y /f "%ProgramFiles%\Apple" >nul 2>&1
takeown /r /d y /f "%ProgramFiles%\Apple Computer" >nul 2>&1
takeown /r /d y /f "%ProgramFiles%\Apple Software Update" >nul 2>&1
takeown /r /d y /f "%ProgramFiles%\Bonjour" >nul 2>&1
takeown /r /d y /f "%ProgramFiles%\iPod" >nul 2>&1
takeown /r /d y /f "%ProgramFiles%\iTunes" >nul 2>&1
takeown /r /d y /f "%ProgramFiles(x86)%\Apple" >nul 2>&1
takeown /r /d y /f "%ProgramFiles(x86)%\Apple Computer" >nul 2>&1
takeown /r /d y /f "%ProgramFiles(x86)%\Apple Software Update" >nul 2>&1
takeown /r /d y /f "%ProgramFiles(x86)%\Bonjour" >nul 2>&1
takeown /r /d y /f "%ProgramFiles(x86)%\iPod" >nul 2>&1
takeown /r /d y /f "%ProgramFiles(x86)%\iTunes" >nul 2>&1
echo.

echo 4. Setting permissions on all Apple files in all known possible locations
cacls "%AppData%\Apple" /t /e /g Everyone:f >nul 2>&1
cacls "%AppData%\Apple Computer" /t /e /g Everyone:f >nul 2>&1
cacls "%AppData%\Apple Software Update" /t /e /g Everyone:f >nul 2>&1
cacls "%AppData%\Bonjour" /t /e /g Everyone:f >nul 2>&1
cacls "%AppData%\iPod" /t /e /g Everyone:f >nul 2>&1
cacls "%AppData%\iTunes" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles%\Apple" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles%\Apple Computer" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles%\Apple Software Update" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles%\Bonjour" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles%\iPod" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles%\iTunes" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles(x86)%\Apple" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles(x86)%\Apple Computer" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles(x86)%\Apple Software Update" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles(x86)%\Bonjour" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles(x86)%\iPod" /t /e /g Everyone:f >nul 2>&1
cacls "%CommonProgramFiles(x86)%\iTunes" /t /e /g Everyone:f >nul 2>&1
cacls "%LocalAppData%\Apple" /t /e /g Everyone:f >nul 2>&1
cacls "%LocalAppData%\Apple Computer" /t /e /g Everyone:f >nul 2>&1
cacls "%LocalAppData%\Apple Software Update" /t /e /g Everyone:f >nul 2>&1
cacls "%LocalAppData%\Bonjour" /t /e /g Everyone:f >nul 2>&1
cacls "%LocalAppData%\iPod" /t /e /g Everyone:f >nul 2>&1
cacls "%LocalAppData%\iTunes" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramData%\Apple" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramData%\Apple Computer" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramData%\Apple Software Update" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramData%\Bonjour" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramData%\iPod" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramData%\iTunes" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles%\Apple" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles%\Apple Computer" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles%\Apple Software Update" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles%\Bonjour" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles%\iPod" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles%\iTunes" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles(x86)%\Apple" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles(x86)%\Apple Computer" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles(x86)%\Apple Software Update" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles(x86)%\Bonjour" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles(x86)%\iPod" /t /e /g Everyone:f >nul 2>&1
cacls "%ProgramFiles(x86)%\iTunes" /t /e /g Everyone:f >nul 2>&1
echo.

echo 5. Removing all Apple files in all known possible locations
rd /s /q "%AppData%\Apple" >nul 2>&1
rd /s /q "%AppData%\Apple Computer" >nul 2>&1
rd /s /q "%AppData%\Apple Software Update" >nul 2>&1
rd /s /q "%AppData%\Bonjour" >nul 2>&1
rd /s /q "%AppData%\iPod" >nul 2>&1
rd /s /q "%AppData%\iTunes" >nul 2>&1
rd /s /q "%CommonProgramFiles%\Apple" >nul 2>&1
rd /s /q "%CommonProgramFiles%\Apple Computer" >nul 2>&1
rd /s /q "%CommonProgramFiles%\Apple Software Update" >nul 2>&1
rd /s /q "%CommonProgramFiles%\Bonjour" >nul 2>&1
rd /s /q "%CommonProgramFiles%\iPod" >nul 2>&1
rd /s /q "%CommonProgramFiles%\iTunes" >nul 2>&1
rd /s /q "%CommonProgramFiles(x86)%\Apple" >nul 2>&1
rd /s /q "%CommonProgramFiles(x86)%\Apple Computer" >nul 2>&1
rd /s /q "%CommonProgramFiles(x86)%\Apple Software Update" >nul 2>&1
rd /s /q "%CommonProgramFiles(x86)%\Bonjour" >nul 2>&1
rd /s /q "%CommonProgramFiles(x86)%\iPod" >nul 2>&1
rd /s /q "%CommonProgramFiles(x86)%\iTunes" >nul 2>&1
rd /s /q "%LocalAppData%\Apple" >nul 2>&1
rd /s /q "%LocalAppData%\Apple Computer" >nul 2>&1
rd /s /q "%LocalAppData%\Apple Software Update" >nul 2>&1
rd /s /q "%LocalAppData%\Bonjour" >nul 2>&1
rd /s /q "%LocalAppData%\iPod" >nul 2>&1
rd /s /q "%LocalAppData%\iTunes" >nul 2>&1
rd /s /q "%ProgramData%\Apple" >nul 2>&1
rd /s /q "%ProgramData%\Apple Computer" >nul 2>&1
rd /s /q "%ProgramData%\Apple Software Update" >nul 2>&1
rd /s /q "%ProgramData%\Bonjour" >nul 2>&1
rd /s /q "%ProgramData%\iPod" >nul 2>&1
rd /s /q "%ProgramData%\iTunes" >nul 2>&1
rd /s /q "%ProgramFiles%\Apple" >nul 2>&1
rd /s /q "%ProgramFiles%\Apple Computer" >nul 2>&1
rd /s /q "%ProgramFiles%\Apple Software Update" >nul 2>&1
rd /s /q "%ProgramFiles%\Bonjour" >nul 2>&1
rd /s /q "%ProgramFiles%\iPod" >nul 2>&1
rd /s /q "%ProgramFiles%\iTunes" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Apple" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Apple Computer" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Apple Software Update" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\Bonjour" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\iPod" >nul 2>&1
rd /s /q "%ProgramFiles(x86)%\iTunes" >nul 2>&1
echo.

echo 6. Removing scheduled tasks and shortcuts
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\iTunes" >nul 2>&1
del /f /q "%WinDir%\System32\Tasks\Apple" >nul 2>&1
del /f /q "%WinDir%\System32\Tasks\Bonjour" >nul 2>&1
del /f /q "%WinDir%\System32\Tasks\iPod" >nul 2>&1
del /f /q "%WinDir%\System32\Tasks\iTunes" >nul 2>&1
del /f /q "%SystemDrive%\Users\Public\Desktop\iTunes.lnk" >nul 2>&1
echo.

echo 7. Deleting all known Registry entries
reg delete "HKLM\SOFTWARE\Apple Computer, Inc." /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Apple Inc." /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Apple Mobile Device" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Apple Mobile Device Support" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Apple Application Support" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Apple Mobile Device Service" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Bonjour Service" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\iPod Service" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Clients\Media\iTunes" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Tracing\iTunes_RASAPI32" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Tracing\iTunes_RASMANCS" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\iTunes.exe" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Apple\AppleSoftwareUpdate" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Apple Computer, Inc." /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Apple Inc." /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Apple Mobile Device" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Apple Mobile Device Support" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Apple Application Support" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Apple Mobile Device Service" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Bonjour Service" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\iPod Service" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Clients\Media\iTunes" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Tracing\iTunes_RASAPI32" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Tracing\iTunes_RASMANCS" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\iTunes.exe" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Apple\AppleSoftwareUpdate" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\services\Apple Mobile Device" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\services\Apple Mobile Device Support" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\services\Apple Application Support" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\services\Apple Mobile Device Service" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\services\Bonjour Service" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\services\EventLog\Application\Bonjour Service" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\services\iPod Service" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Apple Computer, Inc." /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Apple Inc." /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Apple Mobile Device" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Apple Mobile Device Support" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Apple Application Support" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Apple Mobile Device Service" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Bonjour Service" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\iPod Service" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Clients\Media\iTunes" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Tracing\iTunes_RASAPI32" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Tracing\iTunes_RASMANCS" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\iTunes.exe" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Apple\AppleSoftwareUpdate" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Apple Computer, Inc." /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Apple Inc." /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Apple Mobile Device" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Apple Mobile Device Support" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Apple Application Support" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Apple Mobile Device Service" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Bonjour Service" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\iPod Service" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Clients\Media\iTunes" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Microsoft\Tracing\iTunes_RASAPI32" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Microsoft\Tracing\iTunes_RASMANCS" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\iTunes.exe" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Apple\AppleSoftwareUpdate" /f >nul 2>&1
echo.
echo iTunes removal complete!
echo Press any key to exit.
pause >nul 2>&1
ENDLOCAL
EXIT
