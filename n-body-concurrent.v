module main

import solver
// import animation
import benchmark


fn main() {
	threads_count := solver.threads
	delta := solver.delta
	g := solver.gravity
	iterations_count := solver.iterations

	mut threads := []thread{cap: threads_count}
	mut to_draw := [][]solver.Body{}

	mut bodies := solver.initial_bodies.clone()

	requests := chan solver.BodyRequest{cap: bodies.len}
	results := chan solver.Body{cap: bodies.len}

	for i in 0 .. bodies.len {
		bodies[i].id = i
	}

	to_draw << bodies.clone()

	mut bmark := benchmark.start()

	for i in 0 .. threads_count {
		threads << go solver.worker_n(requests, results, g, delta, i)
	}

	for _ in 0 .. iterations_count {
		prev_state := bodies.clone()
		for i in 0 .. bodies.len {
			requests <- solver.BodyRequest{
				body: prev_state[i]
				previous_state: prev_state
				id: prev_state[i].id
			}
		}

		for _ in 0 .. bodies.len {
			tmp := <- results
			bodies[tmp.id] = tmp
		}

		to_draw << bodies.clone()

	}

	requests.close()
	threads.wait()

	results.close()
	
	bmark.measure(@FN)

	// animation.start(to_draw)
}
