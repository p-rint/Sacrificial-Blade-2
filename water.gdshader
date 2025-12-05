shader_type spatial;

uniform float waveSize : hint_range(1.0, 3.0, 0.1);
uniform float waveSpeed : hint_range(1.0, 3.0, 0.1);

uniform sampler2D noise;

varying float wave;

void vertex() {
	// Called for every vertex the material is visible on.
	wave = (sin((TIME * waveSpeed) + VERTEX.x - VERTEX.z) - cos(TIME)) * waveSize;
	VERTEX.y += wave;
	//NORMAL.xy = vec2(VERTEX.y);
	
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 noiseTex = texture(noise, UV - TIME/20.0);
	
	ALPHA = ((wave / 4.0) + sin(TIME * 2.0) + .5) - (UV.y);
	ALPHA -= noiseTex.r;
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
