#!/bin/bash
set -o errexit
#set -o pipefail ## it's failing for line 82 + 86
set -o nounset
IFS=$'\n\t'

# ------------------------------------------------------------------
# [Author] joergi -
#          This script is a generic download script for the:
#          - MagPi Downloader (https://github.com/joergi/MagPiDownloader/)
#          - HelloWorld Downloader (https://github.com/joergi/HelloWorldDownloader)
#          - Wireframe Downloader (https://github.com/joergi/WireframeDownloader)
#          - Hackspace Magazine Downloader (https://github.com/joergi/Hackspace-Magazine-Downloader)
#          this script is under GNU GENERAL PUBLIC LICENSE
# ------------------------------------------------------------------

# VERSION=0.2.0
# $1 = download Url (mandatory)
# $2 = outputDir (mandatory)
# $3 = recent issue (not mandatory, because of the special editions)
# $4 = name to save it - needed if $3 is set
# $5 = -f or -l for saying next is first or last
# $6 = first issue / last issue  to download not mandatory
# $7 = -l for saying next is last
# $8 = last issue to download not mandatory

# for special issues, at the moment the last line must be an empty line, else the last one is ignored

recentIssue=1
isRegular=false
newFileName=""

if [[ -z ${1-} ]]; then
  echo "download url can not be empty"
  exit 1
fi

if [[ -z ${2-} ]]; then
  echo "output url can not be empty"
  exit 1
fi

if [ $# -ge 3 ] && [ -n "$3" ]; then
  recentIssue=$3
  isRegular=true
fi

if [ $# -ge 4 ] && [ -n "$4" ] && [ $isRegular == true ]; then
  newFileName=$4
fi

first=-1
last=-1

if [ $# -ge 6 ] && [ -n "$5" ]; then
  if [ "$5" == "-f" ]; then
    first=$6
  elif [ "$5" == "-l" ]; then
    last=$6
  fi
fi

if [ $# -ge 8 ] && [ -n "$7" ]; then
  if [ "$7" == "-l" ]; then
    last=$8
  else #  make else if and let it fail if not - -f
    last=$recentIssue
  fi
fi

downloadUrl=$1
outputDir=$2

siteUrl="$(echo "$downloadUrl" | sed 's/\(https:\/\/[^\/]*\)\/.*$/\1/')"

i=1

if [ "$first" != -1 ]; then
  i=$first
fi

if [ "$last" != -1 ]; then
  recentIssue=$last
else
  last=$recentIssue
fi

regular_download() {
  newFilenameWithPath="$outputDir/$newFileName$i.pdf"
  if [ ! -e "$newFilenameWithPath" ]; then
    wget -O "$newFilenameWithPath" "$pdf_url"
  fi
}

special_download() {
  wget -N "$pdf_url" -P "$outputDir"
}

while [ "$i" -le "$last" ]; do
  printf -v page_url $downloadUrl "$i"

  # c-link download is only for helloworld mag
  pdf_url=$(curl -sf "$page_url" | grep "\"c-link\" download=" | sed 's/^.*href=\"//' | sed 's/\?.*//' | sed "s#^\(/.*\)#$siteUrl\1#")

  if [[ $pdf_url == "" ]]; then
    # Magpi, Wireframe + Hackspace
    pdf_url=$(curl -sf "$page_url" | grep "\"c-link\"" | sed 's/^.*href=\"//' | sed 's/[>"].*//' | sed "s#^\(/.*\)#$siteUrl\1#")

  fi

  if [[ "$isRegular" == true ]]; then
    regular_download
  else
    special_download
  fi

  i=$((i + 1))
done

exit 0
