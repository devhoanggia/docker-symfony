#!/bin/bash

#echo "Starting SSHd..."
#/usr/sbin/sshd

echo "Starting Nginx..."
/usr/sbin/nginx

echo "Starting php-fpm..."
/usr/sbin/php-fpm