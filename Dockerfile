############################################################
# Dockerfile build images
# Version: 0.0.1
# Author: Gia Hoang Nguyen <dev.hoanggia@gmail.com>
############################################################

# Set the base image to Centos
FROM centos:centos7

MAINTAINER "Gia Hoang Nguyen" <dev.hoanggia@gmail.com>

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm

COPY conf/nginx.repo /etc/yum.repos.d/nginx.repo

RUN yum -y --enablerepo=remi,remi-php72 install nginx php-fpm php-common \
    && yum -y --enablerepo=remi,remi-php72 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-pecl-zip php-gd php-mbstring php-mcrypt php-xml php-devel php-pecl-xdebug php-pecl-xhprof

RUN yum -y install supervisor \
    && yum -y install git \
    && yum clean all

RUN cd / && php -r "readfile('https://getcomposer.org/installer');" | php && cp composer.phar /usr/local/bin/composer && chmod -R 777 /usr/local/bin/composer

RUN mkdir -p /www
RUN mkdir -p /logs
RUN chown -R apache:apache /www
RUN chown -R nginx:nginx /var/log/nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# nginx and php setting
COPY conf/symfony.conf /etc/nginx/conf.d/symfony.conf
COPY conf/laravel.conf /etc/nginx/conf.d/laravel.conf
COPY conf/supervisord.conf /etc/supervisord.conf

RUN sed -i -e "s/;date.timezone =/date.timezone = UTC/" /etc/php.ini

RUN usermod -u 1000 apache

#Expose ports
EXPOSE 80

# Kicking in
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]