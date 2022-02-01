module main

import solver
import animation
import benchmark

fn main() {
	delta := solver.delta
	gravity := solver.gravity
	iterations_count := solver.iterations
	
	mut to_draw := [][]solver.Body{cap: 10}
	mut bodies := solver.initial_bodies.clone()

	for i in 0 .. bodies.len {
		bodies[i].id = i
	}

	mut bmark := benchmark.start()

	to_draw << bodies.clone()
	for _ in 0 .. iterations_count {
		prev_state := bodies.clone()
		for i in 0 .. bodies.len {
			bodies[i] = solver.process_body_n(prev_state, bodies[i], i, gravity, delta)
		}
		to_draw << bodies.clone()
		
	}

	bmark.measure(@FN)
	animation.start(to_draw)
}