module solver

import math

pub struct Body {
pub mut:
	id int
	mass f64
	pos Vector
	vel Vector
}

pub struct Vector {
mut:
	x f64
	y f64
	z f64
}

pub fn (v Vector) mul(num f64) Vector {
	return Vector {
		x: v.x*num,
		y: v.y*num,
		z: v.z*num
	}
}

pub fn (v Vector) length() f64 {
	return math.sqrt(v.x*v.x + v.y*v.y + v.z*v.z)
}

pub fn (v Vector) add(v2 Vector) Vector {
	return Vector {
		x: v.x + v2.x,
		y: v.y + v2.y,
		z: v.z + v2.z
	}
}

pub fn (v Vector) sub(v2 Vector) Vector {
	return Vector {
		x: v.x - v2.x,
		y: v.y - v2.y,
		z: v.z - v2.z
	}
}

pub fn (v Vector) copy() Vector {
	return Vector {
		x: v.x,
		y: v.y,
		z: v.z
	}
}

pub fn (v Vector) normalize() Vector {
	len := v.length()
	return Vector {
		x: v.x/len,
		y: v.y/len,
		z: v.z/len
	}
}
