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
}

function vsc {
    param (
        [string]$path = "."
    )

    $vscodePath = "C:\Users\Nutto\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    if (!(Test-Path $vscodePath)) {
        return
    }

    Start-Process -FilePath $vscodePath -ArgumentList $path
    exit
}