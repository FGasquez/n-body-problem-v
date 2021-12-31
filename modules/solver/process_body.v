module solver

import math
// import time

pub fn process_body(bodies []Body, body Body, gravity f64, delta f64, id int) Body {
	mut b := body
	b2 := bodies[0]
	b3 := bodies[1]

	mut r := Vector{}
	// mut f := []Vector{}
	// bodies.delete(id)
	// println("worker id: ${id}")
	r = (body.pos.sub(b2.pos).div(math.pow(body.pos.sub(b2.pos).length(),
				3))).mul(-gravity * b2.mass).sub(body.pos.sub(b3.pos).div(math.pow(body.pos.sub(b3.pos).length(),
				3)).mul(gravity * b3.mass))


	// for i := 0; i < bodies_copy.len; i++ {
	// 	if i != id {
	// 		// -Gm2*(r1-r2/(|r1-r2|^3))
	// 		f << (b.pos.sub(bodies_copy[i].pos).div(math.pow(b.pos.sub(bodies_copy[i].pos).length(),
	// 			3))).mul(-gravity * bodies_copy[i].mass)
	// 	}
	// }

	// -Gm2*(r1-r2/(|r1-r2|^3))-Gm3*(r1-r3/(|r1-r3|^3))
	// r = f[0].add(f[1])


	b.vel = b.vel.add(r.mul(delta))
	b.pos = b.pos.add(body.vel.mul(delta))
	// println("Waiting")
	// time.sleep(5 * 1000000000)
	return b
}
