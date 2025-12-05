shader_type spatial;

render_mode unshaded;
uniform vec4 color : source_color;

uniform float mixAmt : hint_range(0.0, 1.0, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 finalColor = mix(vec4(0,0,0.0,0.0), color, mixAmt);
	ALBEDO = finalColor.rgb;

}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
