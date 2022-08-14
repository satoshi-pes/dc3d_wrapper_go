# dc3d_wrapper_go
go wrapper for the okada (1992) dislocation theory code DC3D.f in fortran77

https://www.bosai.go.jp/e/dc3d.html
https://www.bosai.go.jp/e/txt/DC3Dfortran.txt

### Usage

1. save the source code of "DC3D"
firstly get the "DC3D" source code from NIED website and store it in the same directory such as DC3D.f:

    wget https://www.bosai.go.jp/e/txt/DC3Dfortran.txt -O DC3D.f

2. build test code by executing build.sh

    chmod +x build.sh
    ./build.sh

3. run the test code

    ./main

### Notes
