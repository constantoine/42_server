FROM debian:buster

WORKDIR /data

ADD ./srcs /data/

EXPOSE 80
EXPOSE 443

RUN apt-get update && apt-get upgrade -y
RUN apt-get install nginx -y \
	&& apt-get install mariadb-server mariadb-client -y \
	&& apt-get install php-fpm php-mysql -y \
	&& apt-get install php-mbstring php-zip php-gd php-xml php-pear php-gettext php-cgi -y

RUN mkdir /var/www/html/phpmyadmin \
	&& tar xvzf phpMyAdmin-4.9.5-english.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin \
	&& tar xvzf wordpress-5.3.2.tar.gz -C /var/www/html  \
	&& tar xvf indexless.tar.gz -C /var/www/html \
	&& /bin/cp -f default /etc/nginx/sites-enabled/default \
	&& /bin/cp -f php.ini /etc/php/7.3/fpm/php.ini \
	&& /bin/cp -f test.php /var/www/html/test.php \
	&& /bin/cp -f wp-config.php /var/www/html/wordpress/wp-config.php \
	&& /bin/cp -f config.inc.php /var/www/html/phpmyadmin/config.inc.php \
	&& chown -R www-data:www-data /var/www/html/phpmyadmin \
	&& chown -R www-data:www-data /var/www/html/wordpress \
	&& chmod 660 /var/www/html/phpmyadmin/config.inc.php

RUN service mysql start && mysql -uroot < setup.sql && mysql -uroot < wpdb.sql && service mysql stop

CMD service nginx restart && service php7.3-fpm start && service mysql start && tail -f /dev/null
