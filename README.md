# nginx-docker

[![version)](https://img.shields.io/docker/v/crashvb/nginx/latest)](https://hub.docker.com/repository/docker/crashvb/nginx)
[![image size](https://img.shields.io/docker/image-size/crashvb/nginx/latest)](https://hub.docker.com/repository/docker/crashvb/nginx)
[![linting](https://img.shields.io/badge/linting-hadolint-yellow)](https://github.com/hadolint/hadolint)
[![license](https://img.shields.io/github/license/crashvb/nginx-docker.svg)](https://github.com/crashvb/nginx-docker/blob/master/LICENSE.md)

## Overview

This docker image contains [nginx](https://nginx.com/) with [cgi](https://en.wikipedia.org/wiki/Common_Gateway_Interface) and [php](https://php.net/).

## Entrypoint Scripts

### nginx

The embedded entrypoint script is located at `/etc/entrypoint.d/nginx` and performs the following actions:

1. The PKI certificates are generated or imported.

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  ├─ entrypoint.d/
│  │  └─ nginx
│  ├─ healthcheck.d/
│  │  ├─ fcgi
│  │  ├─ nginx
│  │  └─ php
│  ├─ nginx/
│  │  ├─ sites-available/
│  │  │  └─ default
│  │  └─ nginx.conf
│  └─ supervisor/
│     └─ config.d/
│        ├─ fcgi.conf
│        ├─ nginx.conf
│        └─ php.conf
├─ run/
│  └─ secrets/
│     ├─ nginx.crt
│     ├─ nginx.key
│     └─ nginxca.crt
├─ usr/
│   └─ local/
│      └─ bin/
│        ├─ test-cgi-fcgi
│        └─ test-php-fpm
└─ var/
   └─ hello/
      ├─ hello.cgi
      ├─ hello.html
      └─ hello.php
```

### Exposed Ports

* `80/tcp` - insecure httpd listening port.
* `443/tcp` - secure httpd listening port.

### Volumes

None.

## Development

[Source Control](https://github.com/crashvb/nginx-docker)

