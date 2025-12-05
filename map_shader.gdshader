shader_type spatial;

uniform sampler2D splashMap;
uniform vec4 texture1 : source_color;
uniform vec4 texture2 : source_color;
uniform vec4 texture3 : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 splashTexture = texture(splashMap, UV);
	
	if (splashTexture.r == 1.0)
		ALBEDO = texture1.rgb;
	
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
