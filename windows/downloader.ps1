param (
    [string] $downloadUrl = $( throw "- downloadUrl is required." ),
    [string] $outputDir = $( throw "- outputDir is required." ),
    [int] $recentIssue = 1,
    [int] $firstIssue = 1,
    [int] $lastIssue,
    [bool] $isHelloWorld = $false
)

# Extract the site URL from the download URL
$siteUrl = $downloadUrl -replace "(https://[^\/]+).*", '$1'

Write-Host "helloworld siteUrl is $siteUrl"

for ($i = $firstIssue; $i -le $recentIssue; $i++) {
    $pageUrl = $downloadUrl -f $i


#    # c-link download is only for helloworld mag
#    $pdfUrl = Invoke-WebRequest -Uri $pageUrl -UseBasicParsing |
#            Select-String -Pattern '\"c-link\" download=\"([^\"]+)\"' |
#            ForEach-Object { $_.Matches.Groups[1].Value }
    $page_content = Invoke-WebRequest -Uri $pageUrl
    $pdf_url = ($page_content.Content | Select-String -Pattern '\"c-link\" download=').ToString() -replace '^.*href=\"|(\?.*)$'

    if ($pdf_url -match '^(/.*)') {
        $pdf_url = $siteUrl + $Matches[1]
    }



    if (![string]::IsNullOrEmpty($pdfUrl))
    {
        Write-Host "inside helloworld setting to true"
        $isHelloWorld = $true
    }

    Write-Host "pdfurl is after first $pdfUrl"

    if ( [string]::IsNullOrEmpty($pdfUrl))
    {

        Write-Host "in second"
        # Magpi, Wireframe + Hackspace
        $pdfUrl = Invoke-WebRequest -Uri $pageUrl -UseBasicParsing |
                Select-String -Pattern '\"c-link\" href=\"([^\"]+)\"' |
                ForEach-Object { $_.Matches.Groups[1].Value }
    }

    if ( [string]::IsNullOrEmpty($pdfUrl))
    {
        Write-Host "PDF URL not found for issue $i"
        continue
    }

    Write-Output "isHelloWorld is $isHelloWorld"
    if ($isHelloWorld)
    {
        Write-Output "inside: pdfurl helloworld   ($siteUrl + $pdfUrl) "
    }
    else
    {
        Write-Output "pdfurl   $pdfUrl vor 1."
        $pdfUrl = $pdfUrl -replace '\?.*', ''
        Write-Output "pdfurl   $pdfUrl vor 2."
        $pdfUrl = $pdfUrl -replace '^/', "$siteUrl/"
        Write-Output "pdfurl   $pdfUrl nach 2."
    }






    $pdfFileName = Split-Path $pdfUrl -Leaf
    $pdfFilePath = Join-Path $outputDir $pdfFileName



    Invoke-WebRequest -Uri $pdfUrl -OutFile $pdfFilePath

    Write-Host "Downloaded $pdfFilePath"
}

exit
