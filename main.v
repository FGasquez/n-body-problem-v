module main

import solver
import animation
import gx

fn main() {
	mut threads := []thread{cap: 10}
	mut to_draw := [][]solver.Body{cap: 10}
	requests := chan solver.BodyRequest{cap: 10}
	results := chan solver.Body{cap: 10}
	threads_count := 3
	iterations_count := 100000

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
				y: 50.0
				z: 0.0
			}
			vel: solver.Vector{
				x: 2.5
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

	to_draw << bodies.clone()

	for _ in 0 .. threads_count {
		threads << go solver.worker(requests, results, 9.8, 0.01)
	}

	for _ in 0 .. iterations_count {
		prev_state := bodies.clone()
		for i in 0 .. prev_state.len {
			requests <- solver.BodyRequest{
				body: i
				previous_state: prev_state
			}
		}
		for _ in 0 .. prev_state.len {
			res := <-results
			bodies[res.id] = res
		}
		to_draw << bodies.clone()
	}
	animation.start(to_draw)
}
