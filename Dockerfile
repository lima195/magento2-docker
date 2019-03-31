FROM php:7.1-apache

MAINTAINER Dominik Krebs <dominik.krebs@netzkollektiv.com>

RUN apt-get install software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update

COPY crontab /etc/cron.d/magento2-cron
COPY ./auth.json /var/www/.composer/
COPY ./etc/php/* /usr/local/etc/php/conf.d/
COPY ./etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf 
COPY ./bin/* /usr/local/bin/
COPY ./build.sh /tmp/

RUN /tmp/build.sh && rm /tmp/build.sh

WORKDIR /var/www/html
VOLUME /var/www/html
ENV MAGEDIR /var/www/html
