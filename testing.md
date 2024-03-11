# Testing the downloader

Here are the scripts to test the downloader.sh locally:

## MagPi Regular
### -f 50 -l 52 
```bash
echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/MagPiDownloader/main/sources-for-download/regular-issues.txt)"
bash ./linux_mac//downloader.sh https://magpi.raspberrypi.com/issues/%02d/pdf/download regular 138 MagPi_ -f 50 -l 52
```
###  -l 2
```bash
echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/MagPiDownloader/main/sources-for-download/regular-issues.txt)"
bash ./linux_mac//downloader.sh https://magpi.raspberrypi.com/issues/%02d/pdf/download regular 138 MagPi_ -l 2
```
###  -f from 2nd last
```bash
bash ./linux_mac//downloader.sh https://magpi.raspberrypi.com/issues/%02d/pdf/download regular 138 MagPi_ -f 137
```

----

## MagPi Books
```bash
 bash ./linux_mac/downloader.sh https://magpi.raspberrypi.com/books/projects-5/pdf/download books
```

----

## Hackspace Magazine Regular
### -f 50 -l 52
```bash 
bash ./linux_mac//downloader.sh https://hackspace.raspberrypi.com/issues/%02d/pdf/download regular 75 HS_ -f 50 -l 52
```
###  -l 2
```bash 
bash ./linux_mac//downloader.sh https://hackspace.raspberrypi.com/issues/%02d/pdf/download regular 75 HS_ -l 2
``` 
###  -f from 2nd last
```bash 
bash ./linux_mac//downloader.sh https://hackspace.raspberrypi.com/issues/%02d/pdf/download regular 75 HS_ -f 74
``` 
----
## Hackspace Magazine Books
```bash 
bash ./linux_mac/downloader.sh https://hackspace.raspberrypi.com/books/meadiaplayer/pdf/download books
```
----

## Hello World Magazin Regular
```bash 
bash ./linux_mac//downloader.sh https://www.raspberrypi.org/hello-world/issues/%02d regular 22 HelloWorld_ -f 4 -l 5
```
---- 
## Hello World Magazin Books
```bash 
bash ./linux_mac/downloader.sh https://helloworld.raspberrypi.org/books/big_book_of_pedagogy/pdf books
```

