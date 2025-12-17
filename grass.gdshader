shader_type spatial;

render_mode cull_disabled;

uniform vec4 colorTop : source_color;
uniform vec4 colorBottom : source_color;

uniform sampler2D noise : source_color;

uniform vec2 windDir = vec2(1.0,0);
uniform float windSpeed : hint_range(0.0, 1.0, 0.02);
uniform float windStrength : hint_range(0.0, .3, 0.01);

varying float height;

varying vec3 worldPos;

varying vec4 windPos;

void vertex() {
	// Called for every vertex the material is visible on.
	
	mat4 invMatrix = inverse(MODEL_MATRIX);
	
	worldPos = (invMatrix * vec4(1.0)).xyz;
	
	vec4 swayPos = invMatrix * vec4(windDir.x, 0.0, windDir.y, 0.0);
	
	windPos = texture(noise, worldPos.xz/10.0 + TIME * windSpeed);
	//NORMAL = -NORMAL;
	height = 1.0 - UV.y;
	
	//VERTEX.xz += (windPos.rr) * height;
	//VERTEX.x += -pow(height, 1.2);
	
	
	VERTEX -= (inverse(MODEL_MATRIX) * vec4(windPos.x, 0.0, windPos.z,0)).xyz * pow(height, 1.3);
	}

void fragment() {
	
	
	ALBEDO = mix(colorBottom, colorTop, height * 2.0).rgb;
	
	NORMAL = mix(NORMAL, vec3(0.0,1.0,0.0), height);
	
	ALBEDO = mix(ALBEDO, windPos.rgb, .8);


//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
}