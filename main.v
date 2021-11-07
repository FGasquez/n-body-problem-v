module main

import solver

fn main() {
	mut threads := []thread {}
	requests := chan solver.BodyRequest{cap: 10}
	results := chan solver.Body{cap: 10}
	threads_count := 2

	mut bodies := [
		solver.Body{
			id: 1
			mass: 2
			pos: solver.Vector{
				x: 1
				y: 2
				z: 3
			} 
			vel: solver.Vector{
				x: 3
				y: 5
				z: 3
			}
		},
		solver.Body{
			id: 2
			mass: 123
			pos: solver.Vector{
				x: 11
				y: 22
				z: 33
			} 
			vel: solver.Vector{
				x: 32
				y: 51
				z: 31
			}
		},
		solver.Body{
			id: 3
			mass: 41
			pos: solver.Vector{
				x: 12
				y: 34
				z: 23
			} 
			vel: solver.Vector{
				x: 15
				y: 31
				z: 25
			}
		}
	]


	for _ in 0 .. threads_count {
		threads << go solver.worker(requests, results, 9.8, 0.5)
	}

	for times in 0 .. 10 {
		println(" ---------------- iteration $times ------------------ ")
		prev_state := bodies.clone()
		bodies = []
		for i in 0 .. prev_state.len {
			requests <- solver.BodyRequest{
				body: i,
				previous_state: prev_state
			}
		}
		for _ in 0 .. prev_state.len {
			body := <- results
			bodies << body
			println(body)
		}
	}
}
