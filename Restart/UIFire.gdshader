shader_type canvas_item;

uniform sampler2D noise : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
uniform sampler2D gradient;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

uniform vec2 dir = vec2(0,.7);

uniform float strength : hint_range(1.1, 3.0, 0.01) = 1.2;
uniform float height : hint_range(-1, 1.0, 0.01)= -.8;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 distortedUV = UV + texture(noise2, UV + dir * TIME).r * .05;
	//vec4 screenTex = texture(TEXTURE, SCREEN_UV);
	vec4 noi = texture(noise, UV + (dir * TIME));
	float energy = noi.r;
	vec4 color = texture(gradient, vec2(energy));
	
	
	vec4 distortedTexture = texture(SCREEN_TEXTURE, distortedUV);
	
	COLOR = mix(COLOR, distortedTexture,  UV.y);
	COLOR -= (color.r - (UV.y + height)) * strength;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
