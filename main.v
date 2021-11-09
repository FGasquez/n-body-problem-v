module main

import solver
import animation
import gx


fn main() {
	mut threads := []thread {cap: 10}
	mut to_draw := [][]solver.Body{cap: 10}
	requests := chan solver.BodyRequest{cap: 10}
	results := chan solver.Body{cap: 10}
	threads_count := 3
	iterations_count := 200000

	mut bodies := [
		solver.Body{
			id: 1
			mass: 10.0
			color: gx.red
			pos: solver.Vector{
				x: 290.0
				y: 310.0
				z: -11.0
			} 
			vel: solver.Vector{
				x: -3.0
				y: 00.0
				z: 00.0
			}
		},
		solver.Body{
			id: 2
			mass: 20.0
			color: gx.green
			pos: solver.Vector{
				x: 300.0
				y: 300.0
				z: 300.0
			} 
			vel: solver.Vector{
				x: 0.0
				y: 0.0
				z: 0.0
			}
		},
		solver.Body{
			id: 3
			mass: 300.0
			color: gx.yellow
			pos: solver.Vector{
				x: 310.0
				y: 310.0
				z: 312.0
			} 
			vel: solver.Vector{
				x: 3.0
				y: 0.0
				z: 0.0
			}
		}
	]

	to_draw << bodies.clone()
	
	for _ in 0 .. threads_count {
		threads << go solver.worker(requests, results, 9.8, 0.5)
	}

	for times in 0 .. iterations_count {
		prev_state := bodies.clone()
		bodies = []
		for i in 0 .. prev_state.len {
			requests <- solver.BodyRequest{
				body: i,
				previous_state: prev_state
			}
		}
		for i in 0 .. prev_state.len {
			body := <- results
			bodies << body
		}
		to_draw << bodies.clone()
	}
	animation.start(to_draw)
}
