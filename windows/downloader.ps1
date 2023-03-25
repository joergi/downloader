param (
    [string] $downloadUrl = $(throw "- downloadUrl is required."),
    [string] $outputDir = $(throw "- outputDir is required."),
    [int] $recentIssue = 1,
    [int] $firstIssue = 1,
    [int] $lastIssue
)

# Extract the site URL from the download URL
$siteUrl = $downloadUrl -replace "(https://[^\/]+).*",'$1'

for ($i = $firstIssue; $i -le $recentIssue; $i++) {
    $pageUrl = $downloadUrl -f $i

    # c-link download is only for helloworld mag
    $pdfUrl = Invoke-WebRequest -Uri $pageUrl -UseBasicParsing |
            Select-String -Pattern '\"c-link\" download=\"([^\"]+)\"' |
            ForEach-Object { $_.Matches.Groups[1].Value }

    if ([string]::IsNullOrEmpty($pdfUrl)) {
        # Magpi, Wireframe + Hackspace
        $pdfUrl = Invoke-WebRequest -Uri $pageUrl -UseBasicParsing |
                Select-String -Pattern '\"c-link\" href=\"([^\"]+)\"' |
                ForEach-Object { $_.Matches.Groups[1].Value }
    }

    if ([string]::IsNullOrEmpty($pdfUrl)) {
        Write-Host "PDF URL not found for issue $i"
        continue
    }

    $pdfUrl = $pdfUrl -replace '\?.*',''
    $pdfUrl = $pdfUrl -replace '^/', "$siteUrl/"



    $pdfFileName = Split-Path $pdfUrl -Leaf
    $pdfFilePath = Join-Path $outputDir $pdfFileName

    Write-Output "xxxx" + $pdfUrl

    Invoke-WebRequest -Uri $pdfUrl -OutFile $pdfFilePath

    Write-Host "Downloaded $pdfFilePath"
}

exit
