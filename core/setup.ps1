if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "Step 1: oh-my-posh is not installed. Installing..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
    $env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"
    try {
        Start-Process -FilePath "winget" -ArgumentList "install JanDeDobbeleer.OhMyPosh -s winget" -Wait -NoNewWindow
        Write-Host "Step 1: oh-my-posh installed successfully."
    } catch {
        Write-Host "Error: Failed to install oh-my-posh via winget." -ForegroundColor Red
    }
} else {
    Write-Host "Step 1: oh-my-posh is already installed."
}
if (-not (Get-Module -ListAvailable PSReadLine)) {
    Write-Host "Step 2: PSReadLine is not installed. Installing..."
    try {
        Install-Module -Name PSReadLine -Force -Scope CurrentUser
        Write-Host "Step 2: PSReadLine installed successfully."
    } catch {
        Write-Host "Error: Failed to install PSReadLine." -ForegroundColor Red
    }
} else {
    Write-Host "Step 2: PSReadLine is already installed."
}
if (-not (Test-Path -Path $PROFILE)) {
    Write-Host "Step 3: $PROFILE does not exist. Creating..."
    try {
        New-Item -Path $PROFILE -Type File -Force
        Write-Host "Step 3: $PROFILE created successfully."
    } catch {
        Write-Host "Error: Failed to create $PROFILE" -ForegroundColor Red
    }
} else {
    Write-Host "Step 3: $PROFILE already exists."
}
