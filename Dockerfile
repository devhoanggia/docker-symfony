#Version: 0.0.1
FROM centos:latest
MAINTAINER Hoang Nguyen "dev.hoanggia@gmail.com"
RUN yum -y  update
RUN yum  install -y nano
EXPOSE 85
