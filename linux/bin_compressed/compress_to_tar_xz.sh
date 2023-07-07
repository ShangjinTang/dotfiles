#!/bin/bash

for binary in "$@"; do
    if [ -f "$binary" ]; then
        echo "tar -cJvf $binary.tar.xz $binary"
        tar -cJvf "$binary.tar.xz" "$binary"
    fi
done
