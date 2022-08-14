#!/usr/bin/env bash
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

# get DC3D
if [ ! -f DC3D.f ]; then
    # download the DC3D.f from NIED website
    wget https://www.bosai.go.jp/e/txt/DC3Dfortran.txt -O DC3D.f
fi

go build
