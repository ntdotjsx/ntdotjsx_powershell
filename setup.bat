@echo off
Mode 120,35
title ntdotjsx setting
Reg.exe add HKLM /F >nul 2>&1

:lobby
sleep 800
chcp 65001
cls
pause
cls
echo Please wait...

regedit /s "./core/ntdotjsx.reg"
powershell -ExecutionPolicy Bypass -File "./core/setup.ps1"
powershell -Command "& './core/profile.ps1'"
pause