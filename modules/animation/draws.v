module animation

import math
import solver
import gg
import gx

fn draw_distance(app App, p1 solver.Vector, p2 solver.Vector, offset Offset, conf gx.TextCfg) {
	app.gg.draw_text(offset.x + int((p1.x + p2.x) / 2), offset.y + int((p1.y + p2.y) / 2),
		math.sqrt(math.pow(p1.x - p2.x, 2)).str(), gx.TextCfg{
		color: gx.white
		size: 13
	})
}

fn draw_triangle(app App, p1 solver.Vector, p2 solver.Vector, p3 solver.Vector, offset Offset, color gx.Color, full bool) {
	if full {
		app.gg.draw_triangle_filled(offset.x + int(p1.x), offset.y + int(p1.y), offset.x + int(p2.x),
			offset.y + int(p2.y), offset.x + int(p3.x), offset.y + int(p3.y), color)
		return
	}

	app.gg.draw_line(offset.x + int(p1.x), offset.y + int(p1.y), offset.x + int(p2.x), offset.y + int(p2.y),
		color)
	app.gg.draw_line(offset.x + int(p1.x), offset.y + int(p1.y), offset.x + int(p3.x), offset.y + int(p3.y),
		color)
	app.gg.draw_line(offset.x + int(p3.x), offset.y + int(p3.y), offset.x + int(p2.x), offset.y + int(p2.y),
		color)
}
