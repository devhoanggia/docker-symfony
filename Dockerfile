############################################################
# Dockerfile build images
# Name: Nginx php-fpm
# Description: php56-fpm and nginx for Symfony on Docker
# Version: 0.0.1
# Author: Gia Hoang Nguyen <dev.hoanggia@gmail.com>
############################################################

# Set the base image to Centos
FROM centos:centos7

# File Author / Maintainer
MAINTAINER Gia Hoang Nguyen <dev.hoanggia@gmail.com>

ENV SYMFONY_APP_SOURCE=/source

# Before install
COPY data/nginx.repo /etc/yum.repos.d/nginx.repo
COPY data/install.sh /install.sh
COPY data/start.sh /start.sh
RUN chmod a+x /start.sh
RUN chmod a+x /install.sh

# Install
RUN /install.sh

# After install
COPY data/nginx.conf /etc/nginx/nginx.conf
COPY data/php.ini /etc/php.ini
COPY data/www.conf /etc/nginx/sites-available/www.conf
COPY data/supervisord.conf /etc/supervisord.conf
RUN cd /etc/nginx/sites-enabled/ && ln -s /etc/nginx/sites-available/www.conf

# Expose ports
EXPOSE 80
EXPOSE 443

# ensure www-data has access to file from volume if file are mapped as uid/gid 1000/1000
#RUN usermod -G users www-data

# Kicking in
CMD ["/usr/local/bin/start.sh"]