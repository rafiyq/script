function Merge-Subtitle {
    param (
        $VideoFile,
        $SubtitleFile
    )

    Get-Command ffmpeg
    if ($?) {
        ffmpeg `
        -i "$VideoFile" `
        -f srt -i "$SubtitleFile" `
        -c:v copy `
        -c:a copy `
        -c:s mov_text `
        -metadata:s:s:0 language=eng `
        outfile.mp4
        Remove-Item $VideoFile
        Remove-Item $SubtitleFile
        Rename-Item -Path "outfile.mp4" -NewName $VideoFile
    }
    else {
        Write-Error `
        -Message "Error: ffmpeg is not recognize in the system." `
        -Category NotInstalled
    }
}
function Is-Video-Or-Subtile {
    param (
        $File
    )

    $VideoExtension = "mp4", "avi", "mpg", "mov", "mkv", "wmv"
    $SubtitleExtension = "sub", "str", "srt", "vtt"
    foreach ($FileName in $VideoExtension) {
        if ($File -match ".$Extension$") {
            return "Video"
        }
    }
    foreach ($FileName in $SubtitleExtension) {
        if ($File -match ".$Extension$") {
            return "Subtitle"
        }
    }
}

function main {
    if (Is-Video-Or-Subtile($arg[0]) == "Video") {$VideoFile = $args[0]}
    if (Is-Video-Or-Subtile($arg[1]) == "Subtitle") {$SubtitleFile = $args[1]}

    if (($VideoFile -ne $null) -and ($SubtitleFile -ne $null)) {
        Merge-Subtitle $VideoFile $SubtitleFile
    }
    else {
        Write-Error `
        -Message "Error: Please provide video and subtitle." `
        -Category ObjectNotFound
    }
}

#main
Merge-Subtitle $args[0] $args[1]
