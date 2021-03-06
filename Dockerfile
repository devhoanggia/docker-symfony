############################################################
# Dockerfile build images
# Version: 0.0.1
# Author: Gia Hoang Nguyen <dev.hoanggia@gmail.com>
############################################################

# Set the base image to Centos
FROM centos:centos7

MAINTAINER "Gia Hoang Nguyen" <dev.hoanggia@gmail.com>

COPY conf/nginx.repo /etc/yum.repos.d/nginx.repo

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm

RUN yum -y --enablerepo=remi,remi-php72 install nginx php-fpm php-common \
&& yum -y --enablerepo=remi,remi-php72 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml

RUN yum -y install supervisor \
    && yum -y install git \
    && yum clean all

RUN cd / && php -r "readfile('https://getcomposer.org/installer');" | php && cp composer.phar /usr/local/bin/composer && chmod -R 777 /usr/local/bin/composer

RUN mkdir -p /www && mkdir -p /logs && mkdir -p /var/run/php-fpm \
&& chown -R apache:apache /www && chown -R nginx:nginx /var/log/nginx \
&& echo "daemon off;" >> /etc/nginx/nginx.conf

RUN sed -i -e "s/;date.timezone =/date.timezone = Asia\/Ho_Chi_Minh/" /etc/php.ini \
&& usermod -u 1000 apache

# nginx and php setting
COPY conf/symfony.conf /etc/nginx/conf.d/symfony.conf
COPY conf/laravel.conf /etc/nginx/conf.d/laravel.conf
COPY conf/supervisord.conf /etc/supervisord.conf

#Expose ports
EXPOSE 80 443

# Kicking in
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]