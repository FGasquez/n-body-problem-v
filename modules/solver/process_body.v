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

pub fn process_body_n(bodies []Body, body Body, id int, gravity f64, delta f64) Body {
 	mut b := body
 	mut acceleration := Vector{0, 0, 0}
 
 	if b.unamovable {
 		return b
 	}

 	for i in 0 .. bodies.len {
 	 if i != b.id {
		tmp := (gravity * bodies[i].mass) / math.pow(bodies[i].pos.sub(b.pos).length(), 3)
		acceleration = acceleration.add(bodies[i].pos.sub(b.pos).mul(tmp))
 	 }
 	}
 
 	pos := bodies[id].pos.add(bodies[id].vel.add(acceleration.mul(delta)))
 	vel := bodies[id].vel.add(acceleration)


	 return Body{
	  	...b
	  	pos: pos
	  	vel: vel
	  	mass: bodies[id].mass
	 }
}
