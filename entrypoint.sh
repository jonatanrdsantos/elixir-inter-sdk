#!/bin/sh

export INTER_API_CERT="$(cat /secrets/certificate.crt)"
export INTER_API_KEY="$(cat /secrets/certificate.key)"

exec "$@"
