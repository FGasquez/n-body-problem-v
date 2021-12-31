module main

import solver
import animation
import gx
import benchmark

fn main() {
	gravity := 9.8
	delta := 0.001
	iterations_count := 9000000
	
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
	println(test.len)
	bmark.measure(@FN)
	animation.start(to_draw)
}