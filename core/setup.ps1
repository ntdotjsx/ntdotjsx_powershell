if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "oh-my-posh is not installed. Installing..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
    $env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"
    (Get-Command oh-my-posh).Source
    winget install JanDeDobbeleer.OhMyPosh -s winget
    oh-my-posh font install
    Write-Host "oh-my-posh installed successfully."
} else {
    Write-Host "oh-my-posh is already installed."
}

if (-not (Get-Module -ListAvailable PSReadLine)) {
    Write-Host "PSReadLine is not installed. Installing..."
    Install-Module -Name PSReadLine -Force -Scope CurrentUser
    Write-Host "PSReadLine installed successfully."
} else {
    Write-Host "PSReadLine is already installed."
}

if (-not (Test-Path -Path $PROFILE)) {
    Write-Host "$PROFILE does not exist. Creating..."
    oh-my-posh get shell
    New-Item -Path $PROFILE -Type File -Force
    Write-Host "$PROFILE created successfully."
}
