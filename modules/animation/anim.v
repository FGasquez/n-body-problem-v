module animation

import solver
import gg
import gx

const rate = f64(1) / 60 * 10

fn event(c gg.KeyCode, m gg.Modifier, mut app App) {
	if c.str() == "p" {
		app.anim.pause()
	}

	if c.str() == "a" {
		app.anim.offset.move_x(10)
	}
	if c.str() == "d" {
		app.anim.offset.move_x(-10)
	}
	if c.str() == "w" {
		app.anim.offset.move_y(10)
	}
	if c.str() == "s" {
		app.anim.offset.move_y(-10)
	}
	if c.str() == "u" {
		app.anim.set_speed(app.anim.speed + 1)
	}
	if c.str() == "j" {
		app.anim.set_speed(app.anim.speed - 1)
	}

	if c.str() == "c" {
		app.anim.offset.move_x(300 - app.anim.offset.x)
		app.anim.offset.move_y(300 - app.anim.offset.y)
	}
}

pub fn start(bodies [][]solver.Body) {
	mut app := &App{
		gg: 0
		anim: &Anim{
			bodies: bodies
			time: 0
			speed: 1
			paused: false
			offset: &Offset{
				x: 300,
				y: 300
			}
		}
	}
	app.gg = gg.new_context(
		bg_color: gx.black
		width: 600
		height: 600
		window_title: 'Three body problem'
		frame_fn: frame
		user_data: app
		keydown_fn: event
	)
	app.gg.run()
}

fn frame(mut app App) {

	time := app.anim.time
	// bodies := app.anim.bodies[time]
	app.gg.begin()

	mut min := time - (50 * app.anim.speed)
	if min < 0 {
		min = 0
	}
	for i := min; i <= time - 1; i += app.anim.speed {
		for j := 0; j < app.anim.bodies[i].len; j++ {
			body := app.anim.bodies[i][j]
			app.gg.draw_circle_filled(app.anim.offset.x + f32(body.pos.x), app.anim.offset.y + f32(body.pos.y),
				2.5, gx.gray)
		}
	}

	for i := 0; i < app.anim.bodies[time].len; i++ {
		body := app.anim.bodies[time][i]
		app.gg.draw_circle_filled(app.anim.offset.x + f32(body.pos.x), app.anim.offset.y + f32(body.pos.y),
			f32(body.mass), body.color)
		app.gg.draw_text(app.anim.offset.x + int(body.pos.x), app.anim.offset.y + int(body.pos.y),
			body.vel.length().str(), gx.TextCfg{
			color: gx.red
			size: 13
		})
	}

	app.draw_info(gx.TextCfg{
		color: gx.red
		size: 13
	})
	app.gg.end()
	app.anim.advance()
}
