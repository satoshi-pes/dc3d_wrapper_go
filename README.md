# dc3d_wrapper_go
go wrapper for the okada (1992) dislocation theory code DC3D.f in fortran77

## Usage

1. save the source code of "DC3D"  
firstly get the "DC3D" source code from NIED website and store it in the same directory such as DC3D.f:
```
wget https://www.bosai.go.jp/e/txt/DC3Dfortran.txt -O DC3D.f
```
2. build test code by executing build.sh
```
chmod +x build.sh
./build.sh
```
3. run the test code
```
./main
```
## Notes
#### [C? Go? Cgo!](https://go.dev/blog/cgo)  
Introduction of Go packages that call C code. Fortran examples are also available here:
https://go.dev/misc/cgo/fortran/

#### calling DC3D from golang  
DC3D is coded in Fortran77 and some modification is needed to call from golang directly. So it is easier to write a wrapper code using "iso_c_binding" introduced from Fortran2003. 

The "iso_c_binding" provides a variable type called c_float, which corresponds to real\*4 in fortran77, and in DC3D variables are declared as real\*4, so the wrapper function using "iso_c_binding" is simply as follows: 
```
subroutine dc3d_wrapper(a, x, y, z, c, dip, L, W, U1, U2, U3, d1, d2, d3) bind(C)
  use iso_c_binding, only: c_float, c_int
  implicit none

  real(c_float), intent(inout) :: a, x, y, z, c, dip, L, W, U1, U2, U3
  real(c_float), intent(inout) :: d1, d2,d3
  real(c_float) :: UX, UY, UZ,UXX,UYX,UZX,UXY,UYY,UZY,UXZ,UYZ,UZZ
  integer :: IRET

  call DC3D(a,x,y,z,c,dip, &
    0.d0,L,0.d0,W,U1,U2,U3,  &
    UX,UY,UZ,UXX,UYX,UZX,UXY,UYY,UZY,UXZ,UYZ,UZZ,IRET)

  d1 = UX
  d2 = UY
  d3 = UZ
end subroutine dc3d_wrapper
```
in which the intent variables must be passed carefully. All of the variables of intent(in), intent(out), and intent(inout) should be passed by pointer because the arguments of fortran function and subroutine are passed by reference.  

Moreover, subroutines of Fortran can have multiple return values that is not supported by c language. In that case, multiple return values have to be passed through the arguments of the form "void func(args*...)". 

An example fo cgo wrapper is as follows:
```
/*
// cgo wrapper for dc3d
// subroutine dc3d_wrapper(a, x, y, z, c, dip, L, W, U1, U2, U3, d1, d2, d3) bind(C)
void dc3d_wrapper(float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*);
*/
import "C"
```


## References
#### NIED websiete:
- https://www.bosai.go.jp/e/dc3d.html  
- https://www.bosai.go.jp/e/txt/DC3Dfortran.txt

#### Okada (1992):
Yoshimitsu Okada; Internal deformation due to shear and tensile faults in a half-space. Bulletin of the Seismological Society of America 1992;; 82 (2): 1018–1040. doi: https://doi.org/10.1785/BSSA0820021018
