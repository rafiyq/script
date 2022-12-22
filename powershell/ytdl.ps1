#Get-Command ffmpeg
#Get-Command yt-dlp

function Best {
    param (
        $Arguments
    )

    Write-Output "best video(mp4) + best audio(m4a) + substitle"
    Write-Output "URL: $Video_URL"
    yt-dlp `
    -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' `
    --embed-thumbnail `
    --embed-metadata `
    $Arguments
 
}

function Top {
    param (
        $Arguments
    )

    Write-Output "best video + best audio + substitle"
    Write-Output "URL: $Video_URL"
    yt-dlp `
    -f 'bestvideo+bestaudio' `
    --write-sub `
    --write-auto-sub `
    --sub-lang en `
    --embed-subs `
    $Arguments
 
}

function Music {
    param (
        $Arguments
    )

    Write-Output "downloading music..."
    Write-Output "URL: $Video_URL"
    yt-dlp `
    -o %\(track\)s\ -\ %\(artist\)s.%\(ext\)s `
    -f bestaudio `
    --extract-audio `
    --audio-format mp3 `
    --audio-quality 0 `
    --embed-thumbnail `
    --add-metadata `
    --metadata-from-title %\(track\)s\ -\ %\(artist\)s `
    $Arguments
 
}

function Thumbnail {
    param (
        $Arguments
    )

    Write-Output "Download thumbnail"
    Write-Output "URL: $Video_URL"
    yt-dlp `
    --write-thumbnail `
    --skip-download `
    $Arguments
 
}

function Subtitle {
    param (
        $Arguments
    )

    Write-Output "Download Subtitles"
    Write-Output "URL: $Video_URL"
    yt-dlp `
    --write-auto-subs `
    --write-subs `
    --sub-langs en `
    --convert-subtitles srt `
    --skip-download `
    $Arguments
 
}


function main {
    param (
        $Options,
        $Video_URL
    )
    
    switch ($Options) {
        "best" {
            Best $Video_URL
        }
        "top" {
            Top $Video_URL
        }
       "music" {
            Music $Video_URL
        }
       "thumbnail" {
            Thumbnail $Video_URL
        }
       "subtitle" {
            Subtitle $Video_URL
        }
        Default {
            yt-dlp $Options
        }
    }
    Write-Output "test"
}

main $args[0] $args[1]
