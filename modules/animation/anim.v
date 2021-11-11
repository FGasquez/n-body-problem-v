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
	center := 400
	time := app.anim.time
	bodies := app.anim.bodies[time]
	app.gg.begin()

	app.gg.draw_line(center + f32(bodies[0].pos.x), center + f32(bodies[0].pos.y), center + f32(bodies[1].pos.x), center + f32(bodies[1].pos.y), gx.blue)
	app.gg.draw_line(center + f32(bodies[0].pos.x), center + f32(bodies[0].pos.y), center + f32(bodies[2].pos.x), center + f32(bodies[2].pos.y), gx.blue)
	app.gg.draw_line(center + f32(bodies[1].pos.x), center + f32(bodies[1].pos.y), center + f32(bodies[2].pos.x), center + f32(bodies[2].pos.y), gx.blue)

	mut min := time - 500 
	if min < 0 {
		min = 0
	} 
	for i := min; i <= time; i++ {
		for j := 0; j < app.anim.bodies[i].len; j++ {
			body := app.anim.bodies[i][j]
			if i != time {
				app.gg.draw_circle(center + f32(body.pos.x), center + f32(body.pos.y), 4, gx.gray)
			} else {
				app.gg.draw_circle(center + f32(body.pos.x), center + f32(body.pos.y), f32(body.mass), body.color)
			}
		}
	} 
	app.gg.end()
	app.anim.advance()
}