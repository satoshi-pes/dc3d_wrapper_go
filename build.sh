#!/usr/bin/env bash
# Copyright 2016 The Go Authors. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
set -e

FC=gfortran

goos=$(go env GOOS)

libext="so"
if [ "$goos" = "darwin" ]; then
        libext="dylib"
elif [ "$goos" = "aix" ]; then
        libtext="a"
fi

case "$FC" in
*gfortran*)
  libpath=$(dirname $($FC -print-file-name=libgfortran.$libext))
  if [ "$goos" != "aix" ]; then
          RPATH_FLAG="-Wl,-rpath,$libpath"
  fi
  export CGO_LDFLAGS="$CGO_LDFLAGS $RPATH_FLAG -L $libpath -lm"
  ;;
esac

echo $CGO_LDFLAGS

go build
