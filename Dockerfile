FROM crashvb/supervisord:202303080202@sha256:1f8c30393b8b6851a2a5751614e72c20b644753cfe5aea4ba317238edcead216
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:1f8c30393b8b6851a2a5751614e72c20b644753cfe5aea4ba317238edcead216" \
	org.opencontainers.image.base.name="crashvb/supervisord:202303080202" \
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
COPY hello.* /var/hello/
RUN chown --recursive root:root /var/hello

# Configure: nginx
COPY default.nginx /etc/nginx/sites-available/default
RUN mkdir --parents /var/www && \
	sed --expression="/access_log/caccess_log \/dev\/stdout;" \
		--expression="/error_log/cerror_log stderr warn;" \
		--in-place=.dist /etc/nginx/nginx.conf

# Configure: php-fpm
RUN install --directory --group=www-data --mode=0755 --owner=www-data /var/run/php

# Configure: diagnostics
COPY test-* /usr/local/bin/

# Configure: supervisor
COPY supervisord.fcgi.conf /etc/supervisor/conf.d/fcgi.conf
COPY supervisord.nginx.conf /etc/supervisor/conf.d/nginx.conf
COPY supervisord.php.conf /etc/supervisor/conf.d/php.conf

# Configure: entrypoint
COPY entrypoint.nginx /etc/entrypoint.d/nginx

# Configure: healthcheck
COPY healthcheck.fcgi /etc/healthcheck.d/fcgi
COPY healthcheck.nginx /etc/healthcheck.d/nginx
COPY healthcheck.php /etc/healthcheck.d/php

EXPOSE 80/tcp 443/tcp
