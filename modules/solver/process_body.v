module solver
import math


pub fn process_body(bodies []Body, id int, gravity f64, speed f64) Body {
	mut b := bodies[id]
	mut r := Vector{}
	mut f := []Vector{}


	delta := 0.01

	for i:= 0; i < bodies.len; i++ {
		if i != id {
			// -Gm2*(r1-r2/(|r1-r2|^3))
			f << b.pos.sub(bodies[i].pos)
				.div(math.pow(b.pos.sub(bodies[i].pos).length(), 3))
				.mul(-1 * gravity * bodies[i].mass) // -Gm2*(r1-r2/(|r1-r2|^3))
		}
	}

	// -Gm2*(r1-r2/(|r1-r2|^3))-Gm3*(r1-r3/(|r1-r3|^3))
	r = b.vel.add(f[0].sub(f[1]))
	
	b.vel = b.vel.add(r.mul(delta))
	b.pos =	b.pos.add(r.mul(delta))
	return b
}
