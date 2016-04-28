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
MAINTAINER Gia Hoang Nguyen <dev.hoanggia@gmail.com>

# Install Nginx & PHP-FPM
COPY data/nginx.repo /etc/yum.repos.d/nginx.repo
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum --enablerepo=remi,remi-php56 -y install nginx php-fpm php-common
RUN yum --enablerepo=remi,remi-php56 -y install php-opcache php-pecl-apcu php-cli php-pear php-pdo \
 php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd \
 php-mbstring php-mcrypt php-xml

# Install supervisor
RUN yum -y install supervisor && yum clean all

# Config nginx
COPY data/nginx.conf /etc/nginx/nginx.conf

# Config php.ini
COPY data/php.ini /etc/php.ini

# Create virtual server
RUN mkdir /etc/nginx/sites-available
RUN mkdir /etc/nginx/sites-enabled
COPY data/www.conf /etc/nginx/sites-available/www.conf
RUN cd /etc/nginx/sites-enabled/ && ln -s /etc/nginx/sites-available/www.conf

# Config evironment
ENV SYMFONY_APP_SOURCE=/source \
	SYMFONY_APP_LOGS=/logs

# Check status system
RUN mkdir -p $SYMFONY_APP_SOURCE
RUN mkdir -p $SYMFONY_APP_LOGS
RUN chown -R apache:apache $SYMFONY_APP_DIR $SYMFONY_APP_LOGS

# Supervisor
COPY data/supervisord.conf /etc/supervisord.conf

# Start service
COPY data/start.sh /usr/local/bin/start.sh
RUN chmod a+x /usr/local/bin/start.sh

# Expose ports
EXPOSE 80
EXPOSE 443

# ensure www-data has access to file from volume if file are mapped as uid/gid 1000/1000
#RUN usermod -G users www-data

# Kicking in
CMD ["/usr/local/bin/start.sh"]