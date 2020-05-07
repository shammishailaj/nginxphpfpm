# nginxphpfpm
A repository to have Dockerfile for setting-up nginx+php-fpm

- Version Map

|Version|Ubuntu|PHP|WKHTMLTOPDF|Composer|
|-------|------|---|-----------|--------|
|0.0.6|18.04|7.4.5|0.12.5-1.bionic|1.10.6 2020-05-06 10:28:10|




Available PHP Modules
```
[PHP Modules]
bcmath
calendar
Core
ctype
curl
date
dom
exif
FFI
fileinfo
filter
ftp
gettext
hash
iconv
intl
json
libxml
mbstring
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
Phar
posix
readline
Reflection
session
shmop
SimpleXML
sockets
sodium
SPL
standard
sysvmsg
sysvsem
sysvshm
tokenizer
xml
xmlreader
xmlwriter
xsl
Zend OPcache
zip
zlib

[Zend Modules]
Zend OPcache
```

# How to use

This repository is linked to docker hub. So you may do a direct pull / run at your end:

```
docker run -it -d -v /var/www:/var/www -v /etc/nginx:/etc/nginx -v /tmp/nginxphpfpm/log:/var/log -v /tmp/nginxphpfpm/tmp:/tmp -p 80:80 shammishailaj/nginxphpfpm:0.0.6
```

The above command will pull the v0.0.6 image and start the server at at localhost 80.

Assumptions:
 - You have all the requisite files for `nginx`.(If you do not, please clone this repository and modify the actual path as per your directory structure.)
 - Your laravel project (or any other PHP project) resides at `/var/www`

You may make changes to the aforementioned command to suit your needs.

In case you want any other php extensions installed, clone this repository and modify the `install.sh` script as per your needs.

For production usage, I would recommend moving the code inside the container and then compressing the image using [Docker Slim](https://dockersl.im).
