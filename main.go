package main

import (
	"fmt"
)

func main() {
	testDC3DWrapper()
}

func testDC3DWrapper() {
	dip_degree := 30.
	a := 0.50
	c := 1000.0
	dip_d := dip_degree
	l := 20000.0
	w := 10000.0
	u1 := 1.0
	u2 := 0.0
	u3 := 0.0

	fmt.Println("u1, u2, u3:", u1, u2, u3)
	for i := -50000; i <= 50000; i += 1000 {
		for j := -50000; j <= 50000; j += 1000 {
			x := float64(i)
			y := float64(j)
			z := 0.0

			d1, d2, d3 := dc3d(a, x, y, z, c, dip_d, l, w, u1, u2, u3)
			fmt.Println("x, y, z, u1, u2, u3: ", x, y, z, d1, d2, d3)
		}
	}
}
