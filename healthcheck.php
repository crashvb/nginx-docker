#!/bin/bash

set -e -o pipefail

log "Checking if $(basename "${0}") is healthy ..."
[[ $(pgrep --count --full php-fpm) -gt 0 ]]

