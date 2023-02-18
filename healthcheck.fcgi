#!/bin/bash

set -e -o pipefail

log "Checking if $(basename "${0}") is healthy ..."
[[ $(pgrep --count --full /usr/sbin/fcgiwrap) -gt 0 ]]

