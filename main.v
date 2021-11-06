module main

import solver

fn main() {
	mut threads := []thread {}
	requests := chan solver.BodyRequest{}
	results := chan solver.Body{}
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
		}
	]

	// for i, body in bodies {
	// 	println(body)
	// }
	for i in 1 .. threads_count {
		println("worker $i")
		threads << go solver.worker(requests, results, 9.8, 0.5)
	}
	
	for times in 0 .. 10 {
		println("time $times")
		prev_state := bodies.clone()

		for i, _ in bodies {
			println("push $i")
			requests <- solver.BodyRequest{
				body: i,
				previous_state: prev_state
			}
		}

		println(threads)
		println("----- Body 1 iteration $times ------------")
		println(bodies[1])
	}
}
