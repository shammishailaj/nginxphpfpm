FROM ubuntu:18.04
MAINTAINER Shammi Shailaj
LABEL maintainer="shammishailaj@gmail.com"
ARG DEBIAN_FRONTEND=noninteractive
RUN export LC_ALL="C.UTF-8" && export LANG="C.UTF-8" && export LANGUAGE="C.UTF-8" && export LC_CTYPE="UTF-8"
RUN apt-get update && apt-get -y install apt-utils && apt-get -y upgrade && apt-get -y install gnupg ca-certificates tzdata && ln -sf ../usr/share/zoneinfo/Asia/Kolkata /etc/localtime && date && apt-get install -y wget
RUN wget -qO - http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN /bin/echo -e "deb http://nginx.org/packages/mainline/ubuntu/ bionic nginx\ndeb-src http://nginx.org/packages/mainline/ubuntu/ bionic nginx\n" | tee -a /etc/apt/sources.list.d/nginx.list
RUN cat /etc/apt/sources.list.d/nginx.list
RUN date && locale -a
RUN apt-get install -y software-properties-common && LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php && apt-get update
RUN apt-get -y install nginx php7.4-fpm php7.4-common php7.4-cli php7.4-curl php7.4-bcmath php7.4-mbstring php7.4-intl php7.4-json php7.4-mysqlnd php7.4-readline php7.4-xml git htop fontconfig libxrender1 xfonts-75dpi xfonts-base xfonts-utils libfontenc1 x11-common xfonts-encodings libjpeg-turbo8 && php -m
RUN mkdir /etc/nginx/sites-enabled /etc/nginx/sites-available
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN rm wkhtmltox_0.12.5-1.bionic_amd64.deb
RUN ln -sf ../usr/share/zoneinfo/Asia/Kolkata /etc/localtime && /bin/echo -e "LC_ALL=\"C.UTF-8\"\nLANG=\"C.UTF-8\"\nLANGUAGE=\"C.UTF-8\"\nLC_TYPE=\"UTF-8\"\n" | tee -a /etc/environment && export LC_ALL="en_US.UTF-8" && export LANG="en_US.UTF-8" && export LANGUAGE="en_US.UTF-8" && export LC_TYPE="UTF-8"
ENV NGINX_PORT 80
EXPOSE ${NGINX_PORT}/tcp


RUN mkdir /var/www && touch /var/log/fpm-php.www.log && chmod 777 /var/log/fpm-php.www.log
RUN echo "\n;https://github.com/rlerdorf/php7dev/issues/48#issuecomment-174212265\n;touch /var/log/fpm-php.www.log && chmod 777 /var/log/fpm-php.www.log\ncatch_workers_output = yes\nphp_flag[display_errors] = on\nphp_admin_value[error_log] = /var/log/fpm-php.www.log\nphp_admin_flag[log_errors] = on" | tee -a /etc/php/7.4/fpm/pool.d/www.conf

# Define Mountable Directories
VOLUME ["/etc/nginx", "/var/www", "/var/log/nginx", "/etc/php/7.1/fpm/pool.d", "/tmp"]

#RUN service php7.4-fpm start
# Start Nginx in foreground
CMD /usr/sbin/service php7.4-fpm start; /usr/sbin/nginx -g "daemon off;"
