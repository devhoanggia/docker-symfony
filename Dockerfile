############################################################
# Dockerfile build images
# Version: 0.0.1
# Author: Gia Hoang Nguyen <dev.hoanggia@gmail.com>
############################################################

# Set the base image to Centos
FROM centos:centos7

MAINTAINER "Gia Hoang Nguyen" <dev.hoanggia@gmail.com>

RUN rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm

COPY zend.repo /etc/yum.repos.d/zend.repo

RUN yum -y --enablerepo=remi,remi-php56 install nginx php-fpm php-common \
    && yum -y --enablerepo=remi,remi-php56 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-pecl-zip php-gd php-mbstring php-mcrypt php-xml php-devel

#COPY nginx.repo /etc/yum.repos.d/nginx.repo

RUN yum -y install supervisor \
    && yum -y install git \
    && yum -y install gcc gcc-c++ autoconf automake \
    #&& yum -y install zend-server-nginx-php-5.6 \
    && yum clean all

RUN cd / && php -r "readfile('https://getcomposer.org/installer');" | php && cp composer.phar /usr/local/bin/composer && chmod -R 777 /usr/local/bin/composer

RUN pecl install -f xdebug
COPY xdebug.ini /etc/php.d/xdebug.ini

RUN mkdir -p /data/www
RUN mkdir -p /data/logs
RUN chown -R apache:apache /data
RUN chown -R nginx:nginx /var/log/nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# nginx and php setting
COPY test.local.conf /etc/nginx/conf.d/test.local.conf
COPY dev.local.conf /etc/nginx/conf.d/dev.local.conf
COPY supervisord.conf /etc/supervisord.conf

RUN sed -i -e "s/;date.timezone =/date.timezone = UTC/" /etc/php.ini

RUN usermod -u 1000 apache

#Expose ports
EXPOSE 80

# Kicking in
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]