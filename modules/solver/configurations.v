module solver

import gx

pub const iterations = 100000
pub const gravity = 9.8
pub const threads = 6
pub const delta = 0.001

pub const initial_three_bodies = [
		solver.Body{
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

pub const initial_bodies = [
		Body{
			mass: 30.0
			color: gx.red
			unamovable: false
			pos: Vector{
				x: 50.0
				y: 50.0
				z: 0.0
			}
			vel: Vector{
				x: 0.0
				y: 0.0
				z: 0.0
			}
		},
		Body{
			mass: 4.0
			color: gx.white
			unamovable: false
			pos: Vector{
				x: 10.0
				y: 10.0
				z: 0.0
			}
			vel: Vector{
				x: -1.5
				y: 1.0
				z: 0.0
			}
		},
		Body{
			mass: 6.0
			color: gx.green
			unamovable: false
			pos: Vector{
				x: 90.0
				y: 50.0
				z: 0.0
			}
			vel: Vector{
				x: -1.0
				y: -3.0
				z: 0.0
			}
		},
		Body{
			mass: 10.0
			color: gx.blue
			unamovable: false
			pos: Vector{
				x: -90.0
				y: 70.0
				z: 0.0
			}
			vel: Vector{
				x: 1.5
				y: 1.3
				z: 0.0
			}
		},
		Body{
			mass: 3.0
			color: gx.blue
			unamovable: false
			pos: Vector{
				x: -90.0
				y: 7.0
				z: 0.0
			}
			vel: Vector{
				x: 0.5
				y: -2.3
				z: 0.0
			}
		},
		Body{
			mass: 3.0
			color: gx.blue
			unamovable: false
			pos: Vector{
				x: -190.0
				y: 7.0
				z: 0.0
			}
			vel: Vector{
				x: 0.5
				y: -2.3
				z: 0.0
			}
		},
	]