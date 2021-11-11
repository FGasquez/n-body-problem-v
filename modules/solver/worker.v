module solver

pub struct BodyRequest {
pub mut:
	body int
	previous_state [] Body
}

pub fn worker(request chan BodyRequest, results chan Body, gravity f64, delta f64) {
	for {
		select {
			req := <- request  {
				results <- process_body(req.previous_state, req.body, gravity, delta)
			}
		}

	}
}
