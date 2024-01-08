param (
    [string] $downloadUrl = $(throw "- downloadUrl is required."),
    [string] $outputDir = $(throw "- outputDir is required."),
    [int] $recentIssue = 1,
    [int] $firstIssue = 1,
    [int] $lastIssue
)

# Extract the site URL from the download URL

Write-Output "download url $downloadUrl"
$siteUrl = $downloadUrl -replace "(https://[^\/]+).*",'$1'
Write-Output $siteUrl

for ($i = $firstIssue; $i -le $recentIssue; $i++) {
    $pageUrl = $downloadUrl -f $i

    # c-link download is only for helloworld mag
#    $pdfUrl = Invoke-WebRequest -Uri $pageUrl -UseBasicParsing | Select-String  [regex]::Match($htmlSnippet, '<a class="c-link" download="[^"]+" href="([^"]+)"').Groups[1].Value
#            Select-String -Pattern '\"c-link\" download=\"([^\"]+)\"' |
#            ForEach-Object { $_.Matches.Groups[1].Value }

#    $pdfUrl = [regex]::Match($htmlSnippet, '<a class="c-link" download="[^"]+" href="([^"]+)"').Groups[1].Value
    $pdfUrl = [regex]::Match($htmlSnippet, '<a class="c-link" download="([^"]+)" href="([^"]+)"').Groups[2].Value


    Write-Output "after clink 1st  $pdfUrl"

    $x = [string]::IsNullOrEmpty($pdfUrl)

    Write-Output "xxxxxxxxxxxx  $x"

    if ([string]::IsNullOrEmpty($pdfUrl)) {
        Write-Output "in if §pdfUrl"
        # Magpi, Wireframe + Hackspace
        $pdfUrl = Invoke-WebRequest -Uri $pageUrl -UseBasicParsing |
                Select-String -Pattern '\"c-link\" href=\"([^\"]+)\"' |
                ForEach-Object { $_.Matches.Groups[1].Value }
        Write-Output "after if $pdfUrl"

    }

    if ([string]::IsNullOrEmpty($pdfUrl)) {
        Write-Host "PDF URL not found for issue $i"
        continue
    }

    Write-Output "$pdfUrl"

    $pdfUrl = $pdfUrl -replace '\?.*',''
    $pdfUrl = $pdfUrl -replace '^/', "$siteUrl/"

    $pdfFileName = Split-Path $pdfUrl -Leaf
    $pdfFilePath = Join-Path $outputDir $pdfFileName

    Invoke-WebRequest -Uri $pdfUrl -OutFile $pdfFilePath

    Write-Host "Downloaded $pdfFilePath"
}

exit
