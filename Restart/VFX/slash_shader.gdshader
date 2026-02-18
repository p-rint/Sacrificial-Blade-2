shader_type spatial;

uniform float time : hint_range(0.0, 1.0, 0.1);

uniform sampler2D noise_tex;

render_mode cull_disabled;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO *= 2.0;
	vec4 noi = texture(noise_tex,UV);
	
	//ALPHA = time;
	//ALPHA = noi.r / 3.0;
	if (time > UV.x)
		ALPHA = 0.0;
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
