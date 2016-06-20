FROM crashvb/supervisord:latest
MAINTAINER Richard Davis <crashvb@gmail.com>

# Install packages, download files ...
RUN docker-apt fcgiwrap nginx php-apc php5-cli php5-fpm

# Configure: hello
ADD hello.* /var/hello/
RUN chown --recursive root:root /var/hello

# Configure: nginx
ADD default.nginx /etc/nginx/sites-available/default
RUN mkdir --parents /var/www && \
	sed --in-place "/pid \/run\/nginx.pid;/a daemon off;" /etc/nginx/nginx.conf

# Configure: php5-fpm
RUN sed --in-place "/cgi.fix_pathinfo=/s/^;//" /etc/php5/fpm/php.ini

# Configure: supervisor
ADD supervisord.fcgi.conf /etc/supervisor/conf.d/fcgi.conf
ADD supervisord.nginx.conf /etc/supervisor/conf.d/nginx.conf
ADD supervisord.php.conf /etc/supervisor/conf.d/php.conf

EXPOSE 80/tcp
