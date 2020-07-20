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
# $2 = recent issue (not mandatory, because of the special editions)
# $3 = -f first issue to download
# $4 = -l last issue to download

if [[ -z $1 ]]; then
    echo "download url can not be empty"
    exit 1
fi

recentIssue=1

if [[ ! -z $2 ]]; then
   recentIssue=$2
fi

downloadUrl=$1


i=1

	while :
	do
		case "$3" in
		-f) shift; i="$3";;
		-l) shift; recentIssue="$3";;
		--) shift; break;;
		-*) usage "bad argument $3";;
		*) break;;
		esac
		shift
	done

	while [ "$i" -le "$recentIssue" ]
	do
		printf -v page_url $downloadUrl "$i"
		pdf_url=`curl -sf $page_url | grep c-link | sed 's/^.*href=\"//' | sed 's/\?.*$//'`
		wget -N $pdf_url -P $OUTDIR
		i=$(( i+1 ))
	done

exit 0

