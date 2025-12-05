shader_type spatial;

render_mode unshaded, cull_disabled;

uniform sampler2D texture;
uniform sampler2D noise;
uniform sampler2D noise2;

uniform float time : hint_range(0, 1.0);


uniform sampler2D screentexture : hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 tex = texture(texture,UV);
	vec4 noi = texture(noise, (UV + TIME/1.0)/2.0);
	vec4 noi2 = texture(noise2, UV);
	vec4 screen = texture(screentexture, SCREEN_UV);

	vec4 distort = texture(screentexture, SCREEN_UV - (noi.rr / 2.0));

	ALBEDO = tex.rgb;
	ALBEDO -= distort.rgb;
	ALPHA = tex.r / 2.0;
	ALPHA -= time / 2.0;

	//if (noi2.r < time)
	//	ALPHA = 0.0;
}
//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
