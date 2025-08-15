#!/bin/bash

if [[ $EUID -ne 0 ]]
then
    echo "This script should be run as root." >&2
    exit 1
fi

# install dependencies
apt install libdw-dev systemtap-sdt-dev libunwind-dev libslang2-dev libgtk2.0-dev libperl-dev python-dev binutils-dev libiberty-dev liblzma-dev libzstd-dev libcap-dev libnuma-dev libbabeltrace-dev libbabeltrace-ctf-dev libaudit-dev asciidoc xmlto

# compile perf
make -j$(nproc)

# install perf and doc
path="/usr/lib/linux-tools/$(uname -r)/perf.d"
make prefix="$path" install install-doc
ln -sr "$path"/bin/perf "$path"/../perf
