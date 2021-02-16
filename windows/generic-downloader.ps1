# ------------------------------------------------------------------
# [Author] rubemlrm -
#          This script is a generic download script for the:
#          - MagPi Downloader (https://github.com/joergi/MagPiDownloader/)
#          - HelloWorld Downloader (https://github.com/joergi/HelloWorldDownloader)
#          - Wireframe Downloader (https://github.com/joergi/WireframeDownloader)
#          - Hackspace Magazine Downloader (https://github.com/joergi/Hackspace-Magazine-Downloader)
#          this script is under GNU GENERAL PUBLIC LICENSE
# ------------------------------------------------------------------

# VERSION=0.1
# USAGE="Usage: powershell magpi-issue-downloader.ps1 "


Param(
    [Parameter(Mandatory = $true,
        ValueFromPipeline = $true)]
    [string]$url,
    [Parameter(Mandatory = $true,
        ValueFromPipeline = $true)]
    [string]$outDir,
    [string]$r,
    [string]$f,
    [string]$l
)

# control variables
$i = 1
$web = New-Object system.net.webclient
$errorCount = 0

if ($f) {
    $i = [int]$f
} elseif ($r) {
    $i = [int]$r
}

if ($l) {
    $issues = [int]$l
}

do {
    #start scrapping directory and download files
    $tempCounter = if ($i -le 9) { "{0:00}" -f $i }  Else { $i }
    $fileReponse = ((Invoke-WebRequest -UseBasicParsing "$url$tempCounter/pdf").Links | Where-Object { $_.href -like "http*" } | Where-Object class -eq c-link)
    if ($fileReponse) {
        try {
            $web.DownloadFile($fileReponse.href, "$outDir" + $fileReponse.download)
            Write-Verbose -Message "Downloaded from  $fileReponse.href"
        }
        Catch {
            Write-Verbose -Message $_.Exception | format-list -force
            Write-Verbose -Message "Ocorred an error trying download $fileReponse.download"
            $errorCount++
        }
    }
    $i++
} While ($i -le $issues)
if ($errorCount -gt 0) {
    exit 1
}
