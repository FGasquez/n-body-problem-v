module animation

import solver
import gg
import gx


const rate = f64(1) / 60 * 10

struct App {
mut:
	gg   &gg.Context
	anim &Anim
}

struct Anim {
mut:
	bodies  [][]solver.Body
	time    int
}

fn (mut anim Anim) advance() {
	anim.time += 1
	if anim.time == anim.bodies.len {
		anim.time = 0
	}

}

pub fn start(bodies [][]solver.Body) {
	mut app := &App{
		gg: 0
		anim: &Anim{
			bodies: bodies,
			time: 0
		}
	}
	app.gg = gg.new_context(
		bg_color: gx.black
		width: 600
		height: 600
		window_title: 'Three body problem'
		frame_fn: frame
		user_data: app
	)
	app.gg.run()
}

fn frame(mut app App) {
	time := app.anim.time
	bodies := app.anim.bodies[time]
	app.gg.begin()
	for body in bodies {
		// if body.id == 1 {
		// 	println("{$body.pos.x, $body.pos.y, $body.pos.z}")
		// }
		app.gg.draw_circle(f32(body.pos.x), f32(body.pos.y), 4, body.color)
	}
	app.gg.end()
	app.anim.advance()
}