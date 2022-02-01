module animation

import solver
import gg
import gx

struct App {
mut:
	gg   &gg.Context
	anim &Anim
}

struct Offset {
mut:
	x int
	y int
}

struct Anim {
mut:
	bodies [][]solver.Body
	time   	int
	speed	int
	paused  bool
	offset 	Offset
}

fn (mut anim Anim) advance() {
	if anim.paused {
		return
	}

	anim.time += anim.speed
	if anim.time >= anim.bodies.len {
		anim.time = 0
	}
	if anim.time < 0 {
		anim.time = anim.bodies.len - 1
	}
}

fn (mut anim Anim) set_speed(speed int) {
	anim.speed = speed
}

fn (mut anim Anim) pause() {
	anim.paused = !anim.paused
}

fn (mut off Offset) move_x(x int) {
	off.x += x
}

fn (mut off Offset) move_y(y int) {
	off.y += y
}

fn (app App) draw_info(conf gx.TextCfg) {
	// app.gg.draw_text(0, 0, "FPS: $app.anim.fps", conf)
	app.gg.draw_text(0, 0 + 20, "Time: $app.anim.time", conf)
	app.gg.draw_text(0, 0 + 30, "Offest: { $app.anim.offset.x, $app.anim.offset.y }", conf)
	app.gg.draw_text(0, 0 + 40, "Speed: $app.anim.speed", conf)
}