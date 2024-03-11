# Testing the downloader

Here are the scripts to test the downloader.sh locally:

## MagPi Regular
### -f 50 -l 52 
```bash
echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/MagPiDownloader/main/sources-for-download/regular-issues.txt)"
bash ./linux_mac//downloader.sh https://magpi.raspberrypi.com/issues/%02d/pdf/download regular "$ISSUE_NUMBER" MagPi_ -f 50 -l 52
```
###  -l 2
```bash
echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/MagPiDownloader/main/sources-for-download/regular-issues.txt)"
bash ./linux_mac//downloader.sh https://magpi.raspberrypi.com/issues/%02d/pdf/download regular "$ISSUE_NUMBER" MagPi_ -l 2
```
###  -f from 2nd last
```bash
echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/MagPiDownloader/main/sources-for-download/regular-issues.txt)"
bash ./linux_mac//downloader.sh https://magpi.raspberrypi.com/issues/%02d/pdf/download regular 138 MagPi_ -f 137
```
## MagPi Books
```bash
 bash ./linux_mac/downloader.sh https://magpi.raspberrypi.com/books/projects-5/pdf/download books
```
----

## Hackspace Magazine Regular
### -f 50 -l 52
```bash 
 echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/HackspaceMagazineDownloader/main/issues.txt)"
bash ./linux_mac//downloader.sh https://hackspace.raspberrypi.com/issues/%02d/pdf/download regular "$ISSUE_NUMBER" HS_ -f 50 -l 52
```
###  -l 2
```bash 
echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/HackspaceMagazineDownloader/main/issues.txt)" 
bash ./linux_mac//downloader.sh https://hackspace.raspberrypi.com/issues/%02d/pdf/download regular "$ISSUE_NUMBER" HS_ -l 2
``` 
###  -f from 2nd last
```bash 
echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/HackspaceMagazineDownloader/main/issues.txt)" 
bash ./linux_mac//downloader.sh https://hackspace.raspberrypi.com/issues/%02d/pdf/download regular 75 HS_ -f 74
``` 
----
## Hackspace Magazine Books
```bash 
bash ./linux_mac/downloader.sh https://hackspace.raspberrypi.com/books/meadiaplayer/pdf/download books
```