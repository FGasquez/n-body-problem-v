module animation

import solver
import math
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
	bodies [][]solver.Body
	time   int
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
			bodies: bodies
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

fn draw_distance(app App, p1 solver.Vector, p2 solver.Vector, center int, conf gx.TextCfg) {
	app.gg.draw_text(center + int((p1.x + p2.x) / 2), center + int((p1.y + p2.y) / 2),
		math.sqrt(math.pow(p1.x - p2.x, 2)).str(), gx.TextCfg{
		color: gx.white
		size: 13
	})
}

fn draw_triangle(app App, p1 solver.Vector, p2 solver.Vector, p3 solver.Vector, center int, color gx.Color, full bool) {
	if full {
		app.gg.draw_triangle(center + int(p1.x), center + int(p1.y), center + int(p2.x),
			center + int(p2.y), center + int(p3.x), center + int(p3.y), color)
		return
	}

	app.gg.draw_line(center + int(p1.x), center + int(p1.y), center + int(p2.x), center + int(p2.y),
		color)
	app.gg.draw_line(center + int(p1.x), center + int(p1.y), center + int(p3.x), center + int(p3.y),
		color)
	app.gg.draw_line(center + int(p3.x), center + int(p3.y), center + int(p2.x), center + int(p2.y),
		color)
}

fn frame(mut app App) {
	center := 400
	time := app.anim.time
	bodies := app.anim.bodies[time]
	app.gg.begin()

	draw_triangle(app, bodies[0].pos, bodies[1].pos, bodies[2].pos, center, gx.blue, false)

	draw_distance(app, bodies[0].pos, bodies[1].pos, center, gx.TextCfg{
		color: gx.white
		size: 13
	})

	draw_distance(app, bodies[0].pos, bodies[2].pos, center, gx.TextCfg{
		color: gx.white
		size: 13
	})

	draw_distance(app, bodies[1].pos, bodies[2].pos, center, gx.TextCfg{
		color: gx.white
		size: 13
	})

	mut min := time - 500
	if min < 0 {
		min = 0
	}
	for i := min; i <= time; i++ {
		for j := 0; j < app.anim.bodies[i].len; j++ {
			body := app.anim.bodies[i][j]
			if i != time {
				app.gg.draw_circle(center + f32(body.pos.x), center + f32(body.pos.y),
					4, gx.gray)
			} else {
				app.gg.draw_circle(center + f32(body.pos.x), center + f32(body.pos.y),
					4, body.color)
			}
		}
	}
	app.gg.end()
	app.anim.advance()
}
