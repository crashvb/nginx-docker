FROM crashvb/supervisord:202103212252
LABEL maintainer="Richard Davis <crashvb@gmail.com>"

# Install packages, download files ...
RUN APT_ALL_REPOS=1 docker-apt fcgiwrap nginx php-apcu php-cli php-fpm

# Configure: hello
ADD hello.* /var/hello/
RUN chown --recursive root:root /var/hello

# Configure: nginx
ADD default.nginx /etc/nginx/sites-available/default
RUN mkdir --parents /var/www && \
	sed --in-place "/pid \/run\/nginx.pid;/a daemon off;" /etc/nginx/nginx.conf

# Configure: php-fpm
RUN install --directory --group=www-data --mode=0755 --owner=www-data /var/run/php

# Configure: diagnostics
ADD test-* /usr/local/bin/

# Configure: supervisor
ADD supervisord.fcgi.conf /etc/supervisor/conf.d/fcgi.conf
ADD supervisord.nginx.conf /etc/supervisor/conf.d/nginx.conf
ADD supervisord.php.conf /etc/supervisor/conf.d/php.conf

# Configure: healthcheck
ADD healthcheck.nginx /etc/healthcheck.d/nginx

EXPOSE 80/tcp 443/tcp
