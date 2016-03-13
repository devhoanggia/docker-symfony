############################################################
# Dockerfile to build Nginx Installed Containers
# Based on Centos 7
# Name: Symfony Docker
# Description: Build php-fpm and nginx for Symfony
# Version: 0.0.1
# Author: Gia Hoang Nguyen <dev.hoanggia@gmail.com>
############################################################

# Set the base image to Centos
FROM centos:7

# File Author / Maintainer
MAINTAINER Hoang Nguyen <dev.hoanggia@gmail.com>

ENV SYMFONY_APP_DIR=root

# Install tool
RUN yum -y  update
RUN yum  install -y nano

# Install Nginx
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

COPY $SYMFONY_APP_DIR/nginx.repo /etc/yum.repos.d/

RUN yum --enablerepo=remi,remi-php56 install -y nginx php-fpm php-common
RUN yum --enablerepo=remi,remi-php56 install -y php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml

RUN yum clean all

# Config Nginx
RUN mkdir /srv/nginx/www
RUN mkdir /srv/nginx/logs
RUN chown -R apache:apache srv/nginx
RUN mkdir /etc/nginx/sites-available
RUN mkdir /etc/nginx/sites-enabled

# Copy a configuration file from the current directory
COPY $SYMFONY_APP_DIR/nginx.conf /etc/nginx/
COPY $SYMFONY_APP_DIR/www.conf /etc/nginx/sites-available
COPY $SYMFONY_APP_DIR/health_check.php /srv/nginx/healthcheck

RUN cd /etc/nginx/sites-enabled/ && ln -s /etc/nginx/sites-available/www.conf

# Expose ports
EXPOSE 80
