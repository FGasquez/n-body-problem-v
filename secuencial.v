module main

import solver
import animation
import gx
import benchmark

fn main() {
	gravity := 9.8
	delta := 0.001
	iterations_count := 10000000
	
	mut to_draw := [][]solver.Body{cap: 10}
	mut bodies := [
		solver.Body{
			id: 0
			mass: 50.0
			color: gx.red
			unamovable: false
			pos: solver.Vector{
				x: 10.0
				y: 30.0
				z: 0.0
			}
			vel: solver.Vector{
				x: 0.0
				y: 0.0
				z: 0.0
			}
		},
		solver.Body{
			id: 1
			mass: 4.0
			color: gx.green
			unamovable: false
			pos: solver.Vector{
				x: 10.0
				y: 70.0
				z: 0.0
			}
			vel: solver.Vector{
				x: 3.5
				y: 0.0
				z: 0.0
			}
		},
		solver.Body{
			id: 2
			mass: 5.0
			color: gx.yellow
			unamovable: false
			pos: solver.Vector{
				x: -30.0
				y: -30.0
				z: 0.0
			}
			vel: solver.Vector{
				x: -2.0
				y: 2.0
				z: 0.0
			}
		},
	]

	mut bmark := benchmark.start()

	to_draw << bodies.clone()

	for _ in 0 .. iterations_count {
		b1 := bodies[0]
		b2 := bodies[1]
		b3 := bodies[2]

		bodies[0] = solver.process_body([b2, b3], b1, gravity, delta)
		bodies[1] = solver.process_body([b1, b3], b2, gravity, delta)
		bodies[2] = solver.process_body([b1, b2], b3, gravity, delta)

		// r1 := (b1.pos.sub(b2.pos).div(math.pow(b1.pos.sub(b2.pos).length(),
		// 		3))).mul(-gravity * b2.mass).sub(b1.pos.sub(b3.pos).div(math.pow(b1.pos.sub(b3.pos).length(),
		// 		3)).mul(gravity * b3.mass))
		// r2 := (b2.pos.sub(b1.pos).div(math.pow(b2.pos.sub(b1.pos).length(),
		// 		3))).mul(-gravity * b1.mass).sub(b2.pos.sub(b3.pos).div(math.pow(b2.pos.sub(b3.pos).length(),
		// 		3)).mul(gravity * b3.mass))
		// r3 := (b3.pos.sub(b1.pos).div(math.pow(b3.pos.sub(b1.pos).length(),
		// 		3))).mul(-gravity * b1.mass).sub(b3.pos.sub(b2.pos).div(math.pow(b3.pos.sub(b2.pos).length(),
		// 		3)).mul(gravity * b2.mass))


		// bodies[0].vel = bodies[0].vel.add(r1.mul(delta))
		// bodies[1].vel = bodies[1].vel.add(r2.mul(delta))
		// bodies[2].vel = bodies[2].vel.add(r3.mul(delta))

		// bodies[0].pos = b1.pos.add(b1.vel.mul(delta))
		// bodies[1].pos = b2.pos.add(b2.vel.mul(delta))
		// bodies[2].pos = b3.pos.add(b3.vel.mul(delta))
		to_draw << bodies.clone()
	}
	bmark.measure(@FN)
	animation.start(to_draw)
}