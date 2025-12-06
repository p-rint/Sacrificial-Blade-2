shader_type canvas_item;

//varying float t = 0.0;

void fragment() {
	// Called for every pixel the material is visible on.
	float t = sin(TIME * 3.0)/2.0 + .5;
	COLOR = vec4(COLOR.a - t);
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
