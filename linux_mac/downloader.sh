#!/bin/bash
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
# $2 = recent issue
# $3 = first issue to download
# $4 = last issue to download

if [[ -z $1 ]]; then
    echo "download url can not be empty"
    exit 1
fi

if [[ -z $2 ]]; then
    echo "recent issue can not be empty"
    exit 1
fi

downloadUrl = $1
recentIssue = $2

i=1

	while :
	do
		case "$3" in
		-f) shift; i="$3";;
		-l) shift; issues="$3";;
		--) shift; break;;
		-*) usage "bad argument $3";;
		*) break;;
		esac
		shift
	done

	while [ "$i" -le "$recentIssue" ]
	do
		printf -v page_url $downloadUrl "$i"
		pdf_url=$(curl -sf "$page_url" | grep c-link | sed 's/^.*href=\"//' | sed 's/\?.*$//')
		wget -N "$pdf_url" -P "$OUTDIR"
		i=$(( i+1 ))
	done

exit 0

