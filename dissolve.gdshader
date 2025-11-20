shader_type canvas_item;

uniform sampler2D noise;
uniform sampler2D noise2;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float t = sin(TIME);
	vec4 text = texture(noise, UV);
	vec4 text2 = texture(noise2, UV);
	if (text.r > t - .03)
		COLOR.rgb = vec3(255,255,255) * 20.0;
	if (text.r > t)
		COLOR.a = 0.0;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
