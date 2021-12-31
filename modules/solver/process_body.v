module solver

import math

pub fn process_body(bodies []Body, body Body, gravity f64, delta f64) Body {
	mut b := body
	b2 := bodies[0]
	b3 := bodies[1]

	mut r := Vector{}

	r = (body.pos.sub(b2.pos).div(math.pow(body.pos.sub(b2.pos).length(),
				3))).mul(-gravity * b2.mass).sub(body.pos.sub(b3.pos).div(math.pow(body.pos.sub(b3.pos).length(),
				3)).mul(gravity * b3.mass))


	b.vel = b.vel.add(r.mul(delta))
	b.pos = b.pos.add(body.vel.mul(delta))
	return b
}
