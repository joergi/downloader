# Testing the downloader

Here are the scripts to test the downloader.sh locally:

## Windows:

### MagPi Regular
#### -f 50 -l 52

### MagPi Books
```pwsh
./windows/downloader.ps1 -downloadUrl "https://magpi.raspberrypi.com/books/projects-5/pdf/download" -outputDir "books"
``` 

### Hello World books
```pwsh
./windows/downloader.ps1 -downloadUrl "https://www.raspberrypi.org/hello-world/issues/the-big-book-of-computing-pedagogy" -outputDir "books"
```

### Hackspace books
```pwsh
./windows/downloader.ps1 -downloadUrl "https://hackspace.raspberrypi.com/books/meadiaplayer/pdf/download" -outputDir "books"

```


## Linux + Mac: 
### MagPi Regular
#### -f 50 -l 52 
```bash
echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/MagPiDownloader/main/sources-for-download/regular-issues.txt)"
./linux_mac/downloader.sh https://magpi.raspberrypi.com/issues/%02d/pdf/download regular 138 MagPi_ -f 50 -l 52
```
####  -l 2
```bash
echo "ISSUE_NUMBER=$(curl https://raw.githubusercontent.com/joergi/MagPiDownloader/main/sources-for-download/regular-issues.txt)"
./linux_mac/downloader.sh https://magpi.raspberrypi.com/issues/%02d/pdf/download regular 138 MagPi_ -l 2
```
####  -f from 2nd last
```bash
./linux_mac/downloader.sh https://magpi.raspberrypi.com/issues/%02d/pdf/download regular 138 MagPi_ -f 137
```

### MagPi Books
```bash
./linux_mac/downloader.sh https://magpi.raspberrypi.com/books/projects-5/pdf/download books
```

----

## Hackspace Magazine Regular
### -f 50 -l 52
```bash 
./linux_mac/downloader.sh https://hackspace.raspberrypi.com/issues/%02d/pdf/download regular 75 HS_ -f 50 -l 52
```
###  -l 2
```bash 
./linux_mac/downloader.sh https://hackspace.raspberrypi.com/issues/%02d/pdf/download regular 75 HS_ -l 2
``` 
###  -f from 2nd last
```bash 
./linux_mac/downloader.sh https://hackspace.raspberrypi.com/issues/%02d/pdf/download regular 75 HS_ -f 74
``` 
----
### Hackspace Magazine Books
```bash 
./linux_mac/downloader.sh https://hackspace.raspberrypi.com/books/meadiaplayer/pdf/download books
```

### Hello World Magazin Regular
```bash 
./linux_mac/downloader.sh https://www.raspberrypi.org/hello-world/issues/%d/ regular 22 HelloWorld_ -f 21 -l 22
```
---
```bash 
./linux_mac/downloader.sh https://www.raspberrypi.org/hello-world/issues/%d/ regular 22 HelloWorld_ -f 4 -l 5
```
---
```bash 
./linux_mac/downloader.sh https://www.raspberrypi.org/hello-world/issues/%d/ regular 22 HelloWorld_ -l 2
```
----


---- 
### Hello World Magazin Books
```bash 
./linux_mac/downloader.sh https://www.raspberrypi.org/hello-world/issues/the-big-book-of-computing-content/ books
```

```bash 
./linux_mac/downloader.sh https://www.raspberrypi.org/hello-world/issues/the-big-book-of-computing-pedagogy books
```


