shader_type canvas_item;

//uniform float t : hint_range(0.0, 1.0, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float t = sin(TIME);
	t *= t; //Power it so it's a curve
	
	if (UV.y > t)
		COLOR.a *= 1.0 - (UV.y - t) * 10.0;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
