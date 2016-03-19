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

ENV SYMFONY_APP_DIR=/var/www

ENV SYMFONY_APP_WWW=$SYMFONY_APP_DIR/html \
	SYMFONY_APP_LOGS=$SYMFONY_APP_DIR/logs

# Install Nginx & PHP-FPM
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

COPY root/nginx.repo /etc/yum.repos.d/

RUN yum --enablerepo=remi,remi-php56 install -y nginx php-fpm php-common
RUN yum --enablerepo=remi,remi-php56 install -y php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml

RUN yum install -y supervisor && yum clean all

# Config Nginx
RUN mkdir -p $SYMFONY_APP_WWW
RUN mkdir -p $SYMFONY_APP_LOGS
RUN chown -R apache:apache $SYMFONY_APP_DIR

RUN mkdir /etc/nginx/sites-available
RUN mkdir /etc/nginx/sites-enabled

COPY root/nginx.conf /etc/nginx/
COPY root/www.conf /etc/nginx/sites-available/
COPY root/health_status.php $SYMFONY_APP_WWW/

RUN cd /etc/nginx/sites-enabled/ && ln -s /etc/nginx/sites-available/www.conf

COPY root/start.sh $SYMFONY_APP_DIR/
RUN chmod a+x $SYMFONY_APP_DIR/start.sh
COPY root/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 80

# Kicking in
CMD ["/var/www/start.sh"]