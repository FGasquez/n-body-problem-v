module solver
import benchmark

pub struct BodyRequest {
pub mut:
	id 			   int
	body           Body
	previous_state []Body
}

pub fn worker(request chan BodyRequest, results chan Body, gravity f64, delta f64, id int) {
	mut bmark := benchmark.new_benchmark()
	for {
		req := <-request or { break }
		bmark.step()
		result := process_body_n(req.previous_state, req.id, gravity, delta)
		results <- result
		bmark.ok()
	}
	bmark.stop()
	println(bmark.total_message(@FN + ': worker $id'))
}
