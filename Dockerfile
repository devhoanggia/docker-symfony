############################################################
# Dockerfile build images
# Name: Symfony Docker
# Description: Server with php56-fpm and nginx for symfony
# Version: 0.0.1
# Author: Gia Hoang Nguyen <dev.hoanggia@gmail.com>
############################################################

# Set the base image to Centos
FROM centos:centos7

# File Author / Maintainer
MAINTAINER Hoang Nguyen <dev.hoanggia@gmail.com>

# Install Nginx & PHP-FPM
COPY data/nginx.repo /etc/yum.repos.d/

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

RUN yum --enablerepo=remi,remi-php56 -y install nginx php-fpm php-common
RUN yum --enablerepo=remi,remi-php56 -y install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml
RUN yum -y install supervisor && yum clean all

# Config Nginx
ENV SYMFONY_APP_DIR=/var/www
ENV SYMFONY_APP_SOURCE=$SYMFONY_APP_DIR/html/source \
	SYMFONY_APP_LOGS=$SYMFONY_APP_DIR/logs


RUN mkdir -p $SYMFONY_APP_SOURCE
RUN mkdir -p $SYMFONY_APP_LOGS
RUN chown -R apache:apache $SYMFONY_APP_DIR
RUN mkdir /etc/nginx/sites-available
RUN mkdir /etc/nginx/sites-enabled

COPY data/nginx.conf /etc/nginx/
COPY data/www.conf /etc/nginx/sites-available/
COPY data/check_server.php $SYMFONY_APP_DIR/html/
COPY data/start.sh /usr/local/bin/
COPY data/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN cd /etc/nginx/sites-enabled/ && ln -s /etc/nginx/sites-available/www.conf
RUN chmod a+x /usr/local/bin/start.sh

# Expose ports
EXPOSE 80

# Kicking in
CMD ["/usr/local/bin/start.sh"]