# nginx-docker

## Overview

This docker image contains [nginx](https://nginx.com/) with [cgi](https://en.wikipedia.org/wiki/Common_Gateway_Interface) and [php](https://php.net/).

## Entrypoint Scripts

None.

## Healthcheck Scripts

### nginx

The embedded healthcheck script is located at `/etc/healthcheck.d/nginx` and performs the following actions:

1. Verifies that perl and php are operational.

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  ├─ healthcheck.d/
│  │  └─ nginx
│  ├─ nginx/
│  │  ├─ sites-available/
│  │  │  └─ default
│  │  └─ nginx.conf
│  └─ supervisor/
│     └─ config.d/
│        ├─ fcgi.conf
│        ├─ nginx.conf
│        └─ php.conf
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

* `80/tcp` - nginx listening port.

### Volumes

None.

## Development

[Source Control](https://github.com/crashvb/nginx-docker)

