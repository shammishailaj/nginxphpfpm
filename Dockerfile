FROM ubuntu:18.04
MAINTAINER Shammi Shailaj
LABEL maintainer="shammishailaj@gmail.com"
ARG DEBIAN_FRONTEND=noninteractive

COPY install.sh /
RUN /bin/bash install.sh

ENV NGINX_PORT 80
EXPOSE ${NGINX_PORT}/tcp

# Define Mountable Directories
VOLUME ["/etc/nginx", "/var/www", "/var/log/nginx", "/etc/php/7.1/fpm/pool.d", "/tmp"]

#RUN service php7.4-fpm start
# Start Nginx in foreground
CMD /usr/sbin/service php7.4-fpm start; /usr/sbin/nginx -g "daemon off;"
