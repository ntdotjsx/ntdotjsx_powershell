if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Write-Host "oh-my-posh is not installed. Installing..."
    Install-Module -Name oh-my-posh -Force -Scope CurrentUser
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
    New-Item -Path $PROFILE -Type File -Force
    Write-Host "$PROFILE created successfully."
}
