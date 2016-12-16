############################################################
# Dockerfile build images
# Version: 0.0.1
# Author: Gia Hoang Nguyen <dev.hoanggia@gmail.com>
############################################################

# Set the base image to Centos
FROM centos:centos7

MAINTAINER "Gia Hoang Nguyen" <dev.hoanggia@gmail.com>

# Run updates
#RUN yum -y update; yum clean all;

## Remi Dependency on CentOS 7 and Red Hat (RHEL) 7 ##
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm

## CentOS 7 and Red Hat (RHEL) 7 ##
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# Nginx repo
COPY nginx.repo /etc/yum.repos.d/nginx.repo
COPY composer.phar /usr/local/bin/composer
RUN chmod -R 777 /usr/local/bin/composer

RUN yum -y --enablerepo=remi,remi-php71 install nginx php-fpm php-common
RUN yum -y --enablerepo=remi,remi-php71 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml

RUN yum -y install supervisor; yum clean all

RUN mkdir -p /data/www
RUN mkdir -p /data/logs
RUN chown -R apache:apache /data
RUN chown -R nginx:nginx /var/log/nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# nginx and php setting
COPY testsite.local.conf /etc/nginx/conf.d/testsite.local.conf
COPY symfony.conf /etc/nginx/conf.d/symfony.conf
COPY supervisord.conf /etc/supervisord.conf

#ensure www-data has access to file from volume if file are mapped as uid/gid 1000/1000
#RUN usermod -G users www-data
RUN usermod -u 1000 apache

#Expose ports
EXPOSE 80

# Kicking in
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]