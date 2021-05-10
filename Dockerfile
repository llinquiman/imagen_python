# Ubuntu 20.04
FROM ubuntu:focal-20210416

ENV zona=America/Argentina/Buenos_Aires
RUN ln -snf /usr/share/zoneinfo/$zona /etc/localtime \
	&& echo $zona > /etc/timezone

RUN apt-get update -y \
	&& apt-get install -y zip unzip gzip \
	&& apt-get install -y apache2 apache2-utils

RUN rm -f /var/cache/apt/archives/*.deb \
	/var/cache/apt/archives/partial/*.deb \
	/var/cache/apt/*.bin 2>/dev/null

WORKDIR /var/www

ADD app.zip .

RUN unzip app.zip \
	&& mv frozenyogurtshop/* html/

WORKDIR /

EXPOSE 80

VOLUME ["/var/www/html"]

ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]
