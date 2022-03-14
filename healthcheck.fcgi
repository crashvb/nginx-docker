#!/bin/bash

set -e -o pipefail

log "Checking if $(basename $0) is healthy ..."
[[ "X$(pgrep --count --full /usr/sbin/fcgiwrap)" = "X1" ]]

