module main

import solver
import animation
import benchmark

fn main() {
	delta := solver.delta
	gravity := solver.gravity
	iterations_count := solver.iterations
	
	mut to_draw := [][]solver.Body{cap: 10}
	mut bodies := solver.initial_three_bodies.clone()

	mut bmark := benchmark.start()

	to_draw << bodies.clone()
	mut test := []int{}
	for i in 0 .. iterations_count {
		test << i
		b1 := bodies[0]
		b2 := bodies[1]
		b3 := bodies[2]

		bodies[0] = solver.process_body([b2, b3], b1, gravity, delta)
		bodies[1] = solver.process_body([b1, b3], b2, gravity, delta)
		bodies[2] = solver.process_body([b1, b2], b3, gravity, delta)
		to_draw << bodies.clone()
	}

	bmark.measure(@FN)
	animation.start(to_draw)
}