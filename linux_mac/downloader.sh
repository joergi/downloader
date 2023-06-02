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
# $4 = -f first issue to download not mandatory
# $5 = -l last issue to download not mandatory

# for special issues, at the moment the last line must be an empty line, else the last one is ignored


if [[ -z $1 ]]; then
    echo "download url can not be empty"
    exit 1
fi

if [[ -z $2 ]]; then
    echo "output url can not be empty"
    exit 1
fi

recentIssue=1

if [[ ! -z $3 ]]; then
   recentIssue=$3
fi

first=-1
last=-1

 if [ $# -ge 5 ] && [ -n "$4" ]; then
  if [ "$4" == "-f" ]; then
    first=$5
  elif [ "$4" == "-l" ]; then
    last=$5

  fi
 fi

 if [ $# -ge 7 ] &&[ -n "$6" ]; then
   if [ "$6" == "-l" ]; then
     last=$7
   fi
 else
   last=$recentIssue
 fi

downloadUrl=$1
outputDir=$2

siteUrl="$(echo "$downloadUrl" | sed 's/\(https:\/\/[^\/]*\)\/.*$/\1/')"

i=1
if [ "$first" != -1 ]; then
  i=$first
fi
if [ "last" != -1 ]; then
  recentIssue=$last
fi

	while [ "$i" -le "$last" ]
	do
    # shellcheck disable=SC2059
    printf -v page_url $downloadUrl "$i"

    # c-link download is only for helloworld mag
		pdf_url=$(curl -sf "$page_url" | grep "\"c-link\" download=" | sed 's/^.*href=\"//' | sed 's/\?.*//' | sed "s#^\(/.*\)#$siteUrl\1#")

		if [[ $pdf_url == "" ]]; then
      # Magpi, Wireframe + Hackspace
       pdf_url=$(curl -sf "$page_url" | grep "\"c-link\"" | sed 's/^.*href=\"//' | sed 's/[>"].*//' | sed "s#^\(/.*\)#$siteUrl\1#")

    fi

		wget -N "$pdf_url" -P "$outputDir"
		i=$(( i+1 ))
	done

exit 0
