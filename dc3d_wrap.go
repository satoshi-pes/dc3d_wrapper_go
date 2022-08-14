package main

/*
// cgo wrapper for dc3d
// subroutine dc3d_wrapper(a, x, y, z, c, dip, L, W, U1, U2, U3, d1, d2, d3) bind(C)
void dc3d_wrapper(float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*, float*);
*/
import "C"

func dc3d(a, x, y, z, c, dip, l, w, u1, u2, u3 float64) (d1, d2, d3 float64) {
	var a_c, x_c, y_c, z_c, c_c, dip_c, l_c, w_c, u1_c, u2_c, u3_c C.float
	var d1_c, d2_c, d3_c C.float

	a_c = (C.float)(a)
	x_c = (C.float)(x)
	y_c = (C.float)(y)
	z_c = (C.float)(z)
	c_c = (C.float)(c)
	dip_c = (C.float)(dip)
	l_c = (C.float)(l)
	w_c = (C.float)(w)
	u1_c = (C.float)(u1)
	u2_c = (C.float)(u2)
	u3_c = (C.float)(u3)

	C.dc3d_wrapper(&a_c, &x_c, &y_c, &z_c, &c_c, &dip_c, &l_c, &w_c, &u1_c, &u2_c, &u3_c, &d1_c, &d2_c, &d3_c)

	d1 = float64(d1_c)
	d2 = float64(d2_c)
	d3 = float64(d3_c)

	return d1, d2, d3
}
