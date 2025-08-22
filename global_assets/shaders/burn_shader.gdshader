shader_type canvas_item;

uniform sampler2D noise;
uniform float dissolve_state : hint_range(-0.1, 1.1);
uniform vec4 border_color;
uniform vec4 object_modulate : source_color;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float brightness = (color.r + color.g + color.b) / 3.0;
	COLOR = vec4(mix(color.rgb, vec3(brightness), 0.0), color.a);

	float noise_val = texture(noise, UV).r;

	if (noise_val < dissolve_state) {
		COLOR.a = 0.0;
	} else if (noise_val - 0.06 < dissolve_state) {
		COLOR.rgb = border_color.rgb;
	}

	COLOR *= object_modulate;
}
