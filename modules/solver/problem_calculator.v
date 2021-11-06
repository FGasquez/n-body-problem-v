module solver

pub fn process_body(bodies []Body, id int, gravity f64, speed f64) Body {
	mut b := bodies[id]
	mut force := Vector{0.0, 0.0, 0.0}
	mut dist := Vector{0.0, 0.0, 0.0}
	mut dist_len := 0.0

	for i :=0; i < bodies.len; i++ {
		println("Yo venia procesando como un campeon")
		if i != id {
			// Calculate the distance between the bodies
			dist = b.pos.sub(bodies[i].pos)
			dist_len = dist.length()
			force = dist.mul(b.mass*bodies[i].mass/dist_len/dist_len)
			b.vel = b.vel.add(force)
		}
	}

	println(b)
	return b
}