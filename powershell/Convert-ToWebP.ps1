[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [string]$OutputPath,

    [string]$CwebpPath = "$env:LOCALAPPDATA\libwebp-1.5.0\bin\cwebp.exe",
    [int]$Quality = 85,

    [switch]$Recurse,
    [switch]$DryRun,
    [switch]$Flatten
)

function Image-ToWebP {
    param(
        [string]$FilePath,
        [string]$InputRoot = $null,
        [string]$OutputRoot = $null,
        [switch]$Flatten
    )

    $ext = [System.IO.Path]::GetExtension($FilePath).ToLower()
    if ($ext -in @(".jpg", ".jpeg", ".png", ".bmp", ".tiff")) {

        $outputFile = if ($OutputRoot) {
            if ($Flatten) {
                $flatName = [System.IO.Path]::GetFileNameWithoutExtension($FilePath) + ".webp"
                [System.IO.Path]::Combine($OutputRoot, $flatName)
            } elseif ($InputRoot) {
                $absoluteFilePath = [System.IO.Path]::GetFullPath($FilePath)
                $absoluteInputRoot = [System.IO.Path]::GetFullPath($InputRoot)

                $relativePath = $absoluteFilePath.Substring($absoluteInputRoot.Length).TrimStart('\', '/')
                $targetPath = [System.IO.Path]::Combine($OutputRoot, $relativePath)
                [System.IO.Path]::ChangeExtension($targetPath, ".webp")
            } else {
                [System.IO.Path]::ChangeExtension($FilePath, ".webp")
            }
        } else {
            [System.IO.Path]::ChangeExtension($FilePath, ".webp")
        }

        $outputDir = [System.IO.Path]::GetDirectoryName($outputFile)
        if (!(Test-Path $outputDir)) {
            New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
        }

        if ($DryRun) {
            Write-Host "[DryRun] Would convert: $FilePath -> $outputFile" -ForegroundColor Yellow
        } else {
            Write-Verbose "Converting $FilePath to $outputFile with quality $Quality"
            Write-Host "Converting: $FilePath -> $outputFile"
            #& $CwebpPath -q $Quality "`"$FilePath`"" -o "`"$outputFile`""
            & $CwebpPath -q $Quality $FilePath -o $outputFile
        }
    } else {
        Write-Verbose "Skipping unsupported file type: $FilePath"
    }
}

function Process-Directory {
    param(
        [string]$DirPath,
        [string]$OutDir = $null,
        [bool]$Recursive = $false,
        [switch]$Flatten
    )

    Write-Host "Scanning directory: $DirPath (Recurse: $Recursive)" -ForegroundColor Cyan

    $files = Get-ChildItem -Path $DirPath -File -Recurse:$Recursive
    foreach ($file in $files) {
        Image-ToWebP -FilePath $file.FullName -InputRoot $DirPath -OutputRoot $OutDir -Flatten:$Flatten
    }
}

# --- Validation ---
if (!(Test-Path $InputPath)) {
    Write-Host "Error: Path '$InputPath' does not exist." -ForegroundColor Red
    exit 1
}

$inputItem = Get-Item $InputPath

if ($inputItem.PSIsContainer -and $OutputPath) {
    if (Test-Path $OutputPath) {
        if (-not (Get-Item $OutputPath).PSIsContainer) {
            Write-Host "Error: When input is a directory, OutputPath must be a directory too." -ForegroundColor Red
            exit 1
        }
    } elseif ([System.IO.Path]::GetExtension($OutputPath)) {
        Write-Host "Error: OutputPath appears to be a file, but input is a directory. Please provide a directory as output." -ForegroundColor Red
        exit 1
    }
}

# --- Execution ---
if ($inputItem.PSIsContainer) {
    Process-Directory -DirPath $InputPath -OutDir $OutputPath -Recursive:$Recurse.IsPresent -Flatten:$Flatten
} else {
    Image-ToWebP -FilePath $InputPath -OutputRoot $OutputPath -Flatten:$Flatten
}
