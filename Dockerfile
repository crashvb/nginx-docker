FROM crashvb/supervisord:202201080446@sha256:8fe6a411bea68df4b4c6c611db63c22f32c4a455254fa322f381d72340ea7226
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:8fe6a411bea68df4b4c6c611db63c22f32c4a455254fa322f381d72340ea7226" \
	org.opencontainers.image.base.name="crashvb/supervisord:202201080446" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing nginx." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/nginx-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/nginx" \
	org.opencontainers.image.url="https://github.com/crashvb/nginx-docker"

# Install packages, download files ...
RUN APT_ALL_REPOS=1 docker-apt fcgiwrap libfcgi-bin nginx php-apcu php-cli php-fpm

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
