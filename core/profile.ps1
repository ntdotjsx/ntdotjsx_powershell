Clear-Content -Path $PROFILE

$text = @'
oh-my-posh init pwsh | Invoke-Expression
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\peru.omp.json" --print) -join "`n"))
Clear-Host
function nthelp {
    $commands = @(
        @{ Name = "ntdotjsx"; Description = "Display 'I LOVE U' message."; Command = "ntdotjsx" }
        @{ Name = "chat"; Description = "Open ChatGPT website in a new browser window."; Command = "chat" }
        @{ Name = "tsk"; Description = "Open Task Manager and display a message."; Command = "tsk" }
        @{ Name = "cast"; Description = "Clear the Recycle Bin and display a confirmation message."; Command = "cast" }
        @{ Name = "reboot"; Description = "Restart the computer after a specified delay (in seconds)."; Command = "reboot" }
        @{ Name = "gone"; Description = "Shut down the computer after a specified delay (in seconds)."; Command = "gone" }
        @{ Name = "vsc"; Description = "Open Visual Studio Code in the specified path (default is current directory)."; Command = "vsc" }
        @{ Name = "dw"; Description = "Download and install Python, Node.js, Lua, or Java."; Command = "dw" }
        @{ Name = "history-cls"; Description = "Clear PowerShell command history and restart the PowerShell session."; Command = "history-cls" }
    )
    $menu = $commands | ForEach-Object { "$($_.Name) - $($_.Description)" }
    Write-Host "Use Arrow Keys to navigate and press Enter to select:" -ForegroundColor Cyan
    $selectedIndex = 0
    while ($true) {
        Clear-Host
        for ($i = 0; $i -lt $menu.Count; $i++) {
            if ($i -eq $selectedIndex) {
                Write-Host " > $($menu[$i])" -ForegroundColor Green
            } else {
                Write-Host "   $($menu[$i])" -ForegroundColor White
            }
        }
        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode
        switch ($key) {
            38 {
                $selectedIndex = ($selectedIndex - 1) % $menu.Count
                if ($selectedIndex -lt 0) { $selectedIndex = $menu.Count - 1 }
            }
            40 { 
                $selectedIndex = ($selectedIndex + 1) % $menu.Count
            }
            13 {
                Clear-Host
                Invoke-Expression $commands[$selectedIndex].Command
                return
            }
        }
    }
}
function ntdotjsx {
    Write-Output "I LOVE U"
}
function chat {
    start "https://chatgpt.com/"
}
function tsk {
    Start-Process "taskmgr.exe"
    Write-Output "! Task Manager"
}
function cast {
    Clear-RecycleBin
    Write-Output "! Throwed away"
}
function reboot {
    param (
        [int]$in = 0
    )

    if ($in -gt 0) {
        Write-Host "The system will restart in $in seconds..."
        Start-Sleep -Seconds $in
    }

    Restart-Computer -Force
}
function gone {
    param (
        [int]$in = 0
    )

    if ($in -gt 0) {
        Write-Host "The system will shutdown in $in seconds..."
        Start-Sleep -Seconds $in
    }

    shutdown /s /f /t 0
}
function vsc {
    param (
        [string]$path = "."
    )
    $vscodePath = "$env:USERPROFILE\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    if (!(Test-Path $vscodePath)) {
        return
    }
    Start-Process -FilePath $vscodePath -ArgumentList $path
    exit
}
function dw {
    $choice = Read-Host "Enter 'python' to install Python, 'node' to install Node.js, 'lua' to install Lua, or 'java' to install Java"

    if ($choice -eq 'python') {
        Write-Host "Downloading and installing Python..."
        Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe" -OutFile "python_installer.exe"
        Start-Process -FilePath .\python_installer.exe -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
        Remove-Item -Path .\python_installer.exe
        Write-Host "Python installation completed."
    }
    elseif ($choice -eq 'node') {
        Write-Host "Downloading and installing Node.js..."
        Invoke-WebRequest -Uri "https://nodejs.org/dist/v18.17.1/node-v18.17.1-x64.msi" -OutFile "node_installer.msi"
        Start-Process -FilePath .\node_installer.msi -ArgumentList "/quiet /norestart" -Wait
        Remove-Item -Path .\node_installer.msi
        Write-Host "Node.js installation completed."
    } 
    elseif ($choice -eq 'lua') {
        Write-Host "Downloading and installing Lua..."
        $luaUrl = "https://www.lua.org/ftp/lua-5.4.7.tar.gz"
        $zipFile = "lua-installer.zip"
        $extractPath = "C:\Lua"
        Invoke-WebRequest -Uri $luaUrl -OutFile $zipFile
        Expand-Archive -Path $zipFile -DestinationPath $extractPath -Force
        Remove-Item -Path $zipFile
        $env:Path += ";$extractPath\lua-5.4.6"
        Write-Host "Lua installation completed."
        lua -v
    }
    elseif ($choice -eq 'java') {
        Write-Host "Downloading and installing Java..."
        $javaUrl = "https://download.oracle.com/java/23/latest/jdk-23_windows-x64_bin.exe"
        $installerPath = "jdk_installer.exe"
        Invoke-WebRequest -Uri $javaUrl -OutFile $installerPath
        Start-Process -FilePath .\$installerPath -ArgumentList "/s" -Wait
        Remove-Item -Path .\$installerPath
        Write-Host "Java installation completed."
        java -version
    }
    else {
        Write-Host "Invalid choice. Please enter 'python', 'node', 'lua', or 'java'."
        return
    }

    $anotherChoice = Read-Host "Do you want to install the other software? (yes/no)"

    if ($anotherChoice -eq 'yes') {
        dw
    } else {
        Write-Host "Installation process completed."
    }
}
function history-cls {
    Remove-Item $env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
    powershell
}
'@

$text | Add-Content -Path $PROFILE