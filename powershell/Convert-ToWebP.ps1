param(
    [Parameter(Mandatory=$true)]
    [string]$InputPath,

    [string]$CwebpPath = "$env:LOCALAPPDATA\libwebp-1.5.0\bin\cwebp.exe",
    [int]$Quality = 85
)

function Convert-ToWebP {
    param(
        [string]$FilePath
    )

    $ext = [System.IO.Path]::GetExtension($FilePath).ToLower()
    if ($ext -in @(".jpg", ".jpeg", ".png", ".bmp", ".tiff")) {
        $outputPath = [System.IO.Path]::ChangeExtension($FilePath, ".webp")
        Write-Host "Converting: $FilePath -> $outputPath"
        & $CwebpPath -q $Quality "`"$FilePath`"" -o "`"$outputPath`""
    }
}

function Process-Directory {
    param(
        [string]$DirPath
    )

    Write-Host "Scanning directory: $DirPath" -ForegroundColor Cyan

    Get-ChildItem -Path $DirPath -Recurse -File | ForEach-Object {
        Convert-ToWebP $_.FullName
    }
}

if (Test-Path $InputPath) {
    if ((Get-Item $InputPath).PSIsContainer) {
        Process-Directory $InputPath
    } else {
        Convert-ToWebP $InputPath
    }
} else {
    Write-Host "Error: Path '$InputPath' does not exist." -ForegroundColor Red
}
