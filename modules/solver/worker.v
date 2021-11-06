module solver

pub struct BodyRequest {
pub mut:
	body int
	previous_state [] Body
}

pub fn worker(request chan BodyRequest, results chan Body, gravity f64, speed f64) {
	select {
		req := <- request  {
			println("------------------------------")
			println("Process body $req.body")
			println(req.previous_state[req.body])
			println("------------------------------")
			results <- process_body(req.previous_state, req.body, gravity, speed)
		}
		else {
			println("Worker exiting")
		}
	}
}
