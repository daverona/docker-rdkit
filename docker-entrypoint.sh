#!/bin/bash
set -e

. /etc/profile.d/rdkit.sh

exec "$@"
