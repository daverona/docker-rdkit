#!/bin/sh
set -e

. /etc/profile.d/rdkit.sh

exec "$@"
