#!/usr/bin/env bash

install_nginx() {
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    yum --enablerepo=remi,remi-php56 -y install nginx php-fpm php-common
    yum --enablerepo=remi,remi-php56 -y install php-opcache php-pecl-apcu php-cli php-pear php-pdo \
        php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd \
        php-mbstring php-mcrypt php-xml

    yum -y install supervisor && yum clean all
}

config_nginx() {
    mkdir /etc/nginx/sites-available
    mkdir /etc/nginx/sites-enabled
    mkdir -p ${SYMFONY_APP_SOURCE}
    chown -R apache:apache ${SYMFONY_APP_DIR}
}

install_nginx
config_nginx