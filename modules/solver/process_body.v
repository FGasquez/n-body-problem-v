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

pub fn process_body_n(bodies []Body, id int, gravity f64, delta f64) Body {
	mut b := bodies[id]
	mut acceleration := Vector{0, 0, 0}
	for i in 0 .. bodies.len {
		if i != id {
			acceleration = acceleration.add(bodies[i].pos.sub(b.pos).div(math.pow(bodies[i].pos.sub(b.pos).length(),
					3)).mul(-gravity * bodies[i].mass))
		}
	}

	// for i in 0 .. bodies.len {
	// 		tmp := gravity * bodies[i].mass / math.pow(body.pos.sub(bodies[i].pos).length(), 3)
	// 		acceleration = body.vel.add(bodies[i].pos.sub(body.pos)).scale(tmp)
	// }
	// positions[i].add(velocities[i].add(accelerations[i].scale(0.5)))

	b.pos = bodies[id].pos.add(bodies[id].vel.add(acceleration.mul(delta)))
	
	// velocities[i] = velocities[i].add(accelerations[i])
	
	b.vel = bodies[id].vel.add(acceleration)
	return b
}

pub fn check_colision(a Body, b Body) bool {
	if a.pos.x == b.pos.x && a.pos.y == b.pos.y && a.pos.z == b.pos.z {
		return true
	}
	return false
}

/** Aceleration

    for i := 0; i < bodies; i++ {
        accelerations[i] = vector{0, 0, 0}
        for j := 0; j < bodies; j++ {
            if i != j {
                temp := gc * masses[j] / math.Pow(positions[i].sub(positions[j]).mod(), 3)
                accelerations[i] = accelerations[i].add(positions[j].sub(positions[i]).scale(temp))
            }
        }
    }