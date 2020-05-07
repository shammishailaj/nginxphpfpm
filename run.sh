#!/bin/sh
/etc/init.d/php7.4-fpm start
/etc/init.d/nginx start

/usr/bin/tail -f /var/log/fpm-php.www.log /var/log/nginx/*log
