FROM ubuntu:18.04
LABEL author="Shammi Shailaj" maintainer="shammi.shailaj@healthians.com"
ARG DEBIAN_FRONTEND=noninteractive

COPY install.sh /
COPY run.sh /
RUN /bin/bash install.sh

ENV NGINX_PORT 80
EXPOSE ${NGINX_PORT}/tcp

# Define Mountable Directories
VOLUME ["/etc/nginx", "/var/www", "/var/log/nginx", "/tmp"]

RUN /etc/init.d/php7.4-fpm start && /etc/init.d/nginx start

# Start Nginx in foreground
#CMD /usr/sbin/service php7.4-fpm start; /usr/sbin/nginx -g "daemon off;"
CMD /bin/sh run.sh