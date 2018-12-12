#!/bin/bash
# Copyright 2018 The Wazo Authors  (see the AUTHORS file)
# SPDX-License-Identifier: GPL-3.0+

admin_ui_plugins=$(dpkg-query -W -f='${binary:Package}\n' | grep -E 'wazo-plugind-admin-ui-.*-official')

is_package_purgeable() {
    local output

    output="$(dpkg-query -W -f '${Status}' "$1" 2>/dev/null)"

    [ "$?" -eq 0 -a "$output" != 'unknown ok not-installed' ]
}

for package in $admin_ui_plugins; do
    if is_package_purgeable $package; then
        apt-get purge -y --force-yes $package
    fi
done