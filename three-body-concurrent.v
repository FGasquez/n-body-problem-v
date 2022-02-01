module main

import solver
// import animation
import benchmark

fn main() {
	mut threads := []thread{cap: 10}
	mut to_draw := [][]solver.Body{cap: 10}
	requests := chan solver.BodyRequest{cap: 10}
	results := chan solver.Body{cap: 10}
	threads_count := solver.threads
	delta := 0.001
	iterations_count := solver.iterations
	g := 9.8

	mut bodies := solver.initial_three_bodies.clone()
	
	for i in 0 .. bodies.len {
		bodies[i].id = i
	}

	to_draw << bodies.clone()

	mut bmark := benchmark.start()

	for i in 0 .. threads_count {
		threads << go solver.worker(requests, results, g, delta, i)
	}

	for _ in 0 .. iterations_count {
		prev_state := bodies.clone()
		requests <- solver.BodyRequest{
			body: prev_state[0],
			previous_state: [prev_state[1], prev_state[2]],
			id: prev_state[0].id
		}
		requests <- solver.BodyRequest{
			body: prev_state[1],
			previous_state: [prev_state[0], prev_state[2]],
			id: prev_state[1].id
		}
		requests <- solver.BodyRequest{
			body: prev_state[2],
			previous_state: [prev_state[0], prev_state[1]],
			id: prev_state[2].id
		}

		for _ in 0 .. prev_state.len {
			res := <-results
			bodies[res.id] = res
		}
		to_draw << bodies.clone()
	}
	requests.close()
	threads.wait()

	results.close()
	
	bmark.measure(@FN)
	// animation.start(to_draw)
}