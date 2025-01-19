Clear-Content -Path $PROFILE

$text = @'
oh-my-posh init pwsh | Invoke-Expression
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\peru.omp.json" --print) -join "`n"))
Clear-Host
function ntdotjsx {
    Write-Output "I LOVE U"
}
function chat {
    start "https://chatgpt.com/"
}
function task {
    Start-Process "taskmgr.exe"
    Write-Output "! Task Manager"
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
