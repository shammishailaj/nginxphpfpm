#!/bin/bash

export LC_ALL="C.UTF-8" && export LANG="C.UTF-8" && export LANGUAGE="C.UTF-8" && export LC_CTYPE="UTF-8"
apt-get update && apt-get -y install apt-utils && apt-get -y upgrade && apt-get -y install gnupg ca-certificates tzdata && ln -sf ../usr/share/zoneinfo/Asia/Kolkata /etc/localtime && date && apt-get install -y wget
wget -qO - http://nginx.org/keys/nginx_signing.key | apt-key add -
/bin/echo -e "deb http://nginx.org/packages/mainline/ubuntu/ bionic nginx\ndeb-src http://nginx.org/packages/mainline/ubuntu/ bionic nginx\n" | tee -a /etc/apt/sources.list.d/nginx.list
cat /etc/apt/sources.list.d/nginx.list
date && locale -a
apt-get install -y software-properties-common && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && apt-get update
apt-get -y install nginx php7.4-fpm php7.4-common php7.4-cli php7.4-curl php7.4-bcmath php7.4-mbstring php7.4-intl php7.4-json php7.4-mysqlnd php7.4-readline php7.4-xml php7.4-zip git htop fontconfig libxrender1 xfonts-75dpi xfonts-base xfonts-utils libfontenc1 x11-common xfonts-encodings libjpeg-turbo8 unzip && php -m
mkdir /etc/nginx/sites-enabled /etc/nginx/sites-available
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
rm wkhtmltox_0.12.5-1.bionic_amd64.deb
ln -sf ../usr/share/zoneinfo/Asia/Kolkata /etc/localtime && /bin/echo -e "LC_ALL=\"C.UTF-8\"\nLANG=\"C.UTF-8\"\nLANGUAGE=\"C.UTF-8\"\nLC_TYPE=\"UTF-8\"\n" | tee -a /etc/environment && export LC_ALL="en_US.UTF-8" && export LANG="en_US.UTF-8" && export LANGUAGE="en_US.UTF-8" && export LC_TYPE="UTF-8"

mkdir /var/www && touch /var/log/fpm-php.www.log && chmod 777 /var/log/fpm-php.www.log
echo "\n;https://github.com/rlerdorf/php7dev/issues/48#issuecomment-174212265\n;touch /var/log/fpm-php.www.log && chmod 777 /var/log/fpm-php.www.log\ncatch_workers_output = yes\nphp_flag[display_errors] = on\nphp_admin_value[error_log] = /var/log/fpm-php.www.log\nphp_admin_flag[log_errors] = on" | tee -a /etc/php/7.4/fpm/pool.d/www.conf

apt-get autoremove -y && apt-get autoclean && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
