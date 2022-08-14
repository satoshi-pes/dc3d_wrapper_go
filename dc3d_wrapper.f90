! This is 
!
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