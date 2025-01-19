@echo off
Mode 120,35
title ntdotjsx setting
Reg.exe add HKLM /F >nul 2>&1
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")

:lobby
sleep 800
chcp 65001
cls
set "emojis=🔍 🗼 👀 🔎"
set "filename=ntdotjsx.reg"
set "fileFound=false"

pause
cls
echo Please wait...

for %%d in (C D E) do (
    for /L %%i in (1,1,5) do (
        for %%e in (%emojis%) do (
            cls
            echo %%e Downloading ...
            timeout /t 1 >nul
        )
    )
    

    for /f "delims=" %%f in ('dir %%d:\%filename% /s /b 2^>nul') do (
        if exist "%%f" (
            cls
            echo File found: %%f
            choice /C YN /M "Press Y to confirm, N to cancel"
            if errorlevel 2 (
                cls
                echo Installation canceled.
                pause
                goto :EOF
            )
            if errorlevel 1 (
                regedit /s "%%f"
                cls
                echo File has been successfully imported into the registry.
                powershell -Command "& './core/profile.ps1'"
                @REM powershell -Command "notepad $PROFILE"
                pause
                goto :EOF
            )
        )
    )
)

cls
echo File "%filename%" was not found on any drive.
pause
